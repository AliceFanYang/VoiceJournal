//
//  ViewController.swift
//  Speak in
//
//  Created by Irene Woo on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import Alamofire
import UIKit
import RealmSwift
import Speech
import Foundation

class EntryController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine() //speech recognition engine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        microphoneButton.isEnabled = false //disable button untill speech is activated by user
        
        //speechRecognizer.delgate = self
        
        //Requests authorization to use speech recognition from user
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case.authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied acess")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToEntryController(segue: UIStoryboardSegue) {}
    
    //microphoneTapped
    //saveText
    
    
    @IBAction func microphoneTapped(_ sender: UIButton) {
        if audioEngine.isRunning { //stop speech recognition
            audioEngine.stop()
            recognitionRequest?.endAudio()
//            microphoneButton.setTitle("Start Recording", for: .normal)
            microphoneButton.isEnabled = false
            saveButton.isEnabled = true
        } else { //start speech recognition
            startRecording()
//            microphoneButton.setTitle("Stop Recording", for: .normal)
            saveButton.isEnabled = false
        }
    }
    
    
    func nameAlert()->String {
        let alert = UIAlertController(title:"Entry name", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ (UIAlertAction) in
        }))
        
        present(alert, animated: true, completion:nil)
        
        return textView.text
    }
    
    func deleteAlert() {
        let alert = UIAlertController(title:"Are you sure?", message: "clicking yes will clear the text area.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ (UIAlertAction) in
            self.textView.text = "Say something, I'm listening!"
        }))
        
        present(alert, animated: true, completion:nil)
    }

   
    @IBAction func deleteTapped(_ sender: UIButton) {
        deleteAlert()
    }
    
    
    @IBAction func saveText(_ sender: AnyObject) {
        let parameters: Parameters = [
            "api_key": "2b0641dfee143ececc9b067b88aa3182",
            "data": self.textView.text
        ]
        
        Alamofire.request("https://apiv2.indico.io/emotion", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard let JSON = response.result.value as? [String: AnyObject]  else { return }
                guard let emotion = JSON["results"] as? [String: Float] else { return }

                let entry = JournalEntry()
                entry.entryText = self.textView.text
                entry.anger = emotion["anger"]!
                entry.joy = emotion["joy"]!
                entry.fear = emotion["fear"]!
                entry.sadness = emotion["sadness"]!
                entry.surprise = emotion["surprise"]!
                entry.entryTitle = self.nameAlert()
                
                entry.date = Date() as NSDate //current date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE',' MMMM dd',' yyyy 'at' h:mm:ss a '('vvvv')'"
                entry.id = dateFormatter.string(from: entry.date as Date!)

                // Save Journal Entry.
                let realm = try! Realm()
                try! realm.write {
                    realm.add(entry)
                    
                }
        }
    }
    
    var tField: UITextField!
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter an item"
        tField = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
    var alert = UIAlertController(title: "Journal Name", message: "", preferredStyle: .alert)

    
    //Listens are parses
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // set the AVAudioSession to record audio
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        //make sure device can record
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        //make sure out recognition request is initiatalized
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Say something, I'm listening!"
        
    }
}

