//
//  CircleChartController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/16/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import Charts
import CoreData

class CircleChartController: UIViewController, ChartViewDelegate {

   var pieChart = PieChartView()
    
    var breadDataEntry = PieChartDataEntry(value: 0)
    var meatDataEntry = PieChartDataEntry(value: 0)
    var cheeseDataEntry = PieChartDataEntry(value: 0)
    var vegetableDataEntry = PieChartDataEntry(value: 0)
    var condimentDataEntry = PieChartDataEntry(value: 0)
    var utensilDataEntry = PieChartDataEntry(value: 0)
    var capDataEntry = PieChartDataEntry(value: 0)
    var cupDataEntry = PieChartDataEntry(value: 0)
    var napkinaspDataEntry = PieChartDataEntry(value: 0)
    var chemicalDataEntry = PieChartDataEntry(value: 0)
    var toiletriesDataEntry = PieChartDataEntry(value: 0)
    var cleaningtoolDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfSubCats = [PieChartDataEntry]()
    var numberOfSubCatsLabels: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        
        pieChart.chartDescription?.text = "Sub-Categories"
        
        numberOfSubCats = [breadDataEntry, meatDataEntry, cheeseDataEntry, vegetableDataEntry, condimentDataEntry, utensilDataEntry, capDataEntry, cupDataEntry, napkinaspDataEntry, chemicalDataEntry, toiletriesDataEntry, cleaningtoolDataEntry]
        numberOfSubCatsLabels = ["Breads", "Meats"]
        
        retrieveData()
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let subCategory = (data.value(forKey: "sub_category") as! String)
                
                switch subCategory {
                    case "breads":
                        breadDataEntry.value = breadDataEntry.value + 1
                        break
                    case "meats":
                        meatDataEntry.value = meatDataEntry.value + 1
                        break
                    case "cheeses":
                        cheeseDataEntry.value = cheeseDataEntry.value + 1
                        break
                    case "vegetables":
                        vegetableDataEntry.value = vegetableDataEntry.value + 1
                        break
                    case "condiments":
                        condimentDataEntry.value = condimentDataEntry.value + 1
                        break
                    case "utensils":
                        utensilDataEntry.value = utensilDataEntry.value + 1
                        break
                    case "containers and plates":
                        capDataEntry.value = capDataEntry.value + 1
                        break
                    case "cups":
                        cupDataEntry.value = cupDataEntry.value + 1
                        break
                    case "napkins and sauce packs":
                        napkinaspDataEntry.value = napkinaspDataEntry.value + 1
                        break
                    case "chemicals":
                        chemicalDataEntry.value = chemicalDataEntry.value + 1
                        break
                    case "toiletries":
                        toiletriesDataEntry.value = toiletriesDataEntry.value + 1
                        break
                    default:
                        cleaningtoolDataEntry.value = cleaningtoolDataEntry.value + 1
                        break
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        pieChart.center = view.center
        view.addSubview(pieChart)
        
       let chartDataSet = PieChartDataSet(entries: numberOfSubCats, label: "sub-Categories")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        chartDataSet.colors = ChartColorTemplates.joyful()
        
        pieChart.data = chartData
    }
    



}
