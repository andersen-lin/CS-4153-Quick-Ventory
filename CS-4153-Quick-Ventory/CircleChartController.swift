//
//  CircleChartController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/16/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

/*import UIKit
import Charts

class CircleChartController: UIViewController, ChartViewDelegate {

   var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [PieChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(PieChartDataEntry(value: Double(x), data: Double(x)))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
    



}*/
