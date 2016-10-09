//
//  GraphController.swift
//  Speak in
//
//  Created by Irene Woo on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftCharts

class GraphController: UIViewController {
    
    @IBOutlet weak var chartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let realm = try! Realm()
        let data = realm.objects(JournalEntry.self)
        var joyValues = [(Double, Double)?]()
        var maxJoy = Float(0)
        var xValue = Double(1)
        for entry in data {
            joyValues.append((xValue, Double(entry.joy)))
            xValue += 1.0
            if entry.joy > maxJoy {
                maxJoy = entry.joy
            }
            print("\(entry.joy)")
        }

        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 1, to: Double(joyValues.count), by: 1),
            yAxisConfig: ChartAxisConfig(from: 0, to: Double(maxJoy+0.1), by: 0.1)
        )
        
        let chart = LineChart(
            frame: CGRect(origin: CGPoint(x: 0,y :100), size: CGSize(width: 300, height: 300)),
            chartConfig: chartConfig,
            xTitle: "Time",
            yTitle: "Emotion Intensity",
            lines: [
                (chartPoints: joyValues as! Array<(Double, Double)>, color: UIColor.white),
                //(chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        
        self.chartView.addSubview(chart.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

