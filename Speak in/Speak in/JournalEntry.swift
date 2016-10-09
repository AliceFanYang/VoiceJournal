//
//  JournalEntry.swift
//  Speak in
//
//  Created by Gunnar Horve on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import Foundation

class JournalEntry {
    var anger, joy, fear, sadness, surprise: Float;
    var id, entryText, entryTitle, dominantEmotion: String
    var date: NSDate

    
    //dynamic var sound = NSData()?
    
    init(id: String, entryTitle: String, date: NSDate, entryText: String, emotions: [Float]) {
        self.id = id
        self.date = date
        self.entryText = entryText
        self.entryTitle = entryTitle
        
        self.anger    =  emotions[0]
        self.joy      =  emotions[1]
        self.fear     =  emotions[2]
        self.sadness  =  emotions[3]
        self.surprise =  emotions[4]
        
        
        //sloppy, and I feel bad, but I no longer care.
        var maxEmotion: Float = emotions[0];
        self.dominantEmotion = "anger"
        var stringList = ["joy","fear","sadness","surprise"]
        for index in 1...4 {
            if(emotions[index] > maxEmotion) {
                self.dominantEmotion = stringList[index]
                maxEmotion = emotions[index]
            }
        }
    }
    
    //    override static func primaryKey() -> String? {
    //        return "id"
    //    }
}
