//
//  BarChartController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/16/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import Charts
import CoreData

class BarChartController: UIViewController, ChartViewDelegate{

    var barChart = BarChartView()
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var itemEntity: NSEntityDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        itemEntity = NSEntityDescription.entity(forEntityName: "item", in:context!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        barChart.center = view.center
        view.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }

}
