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

   var pieChart = PieChartView()//intializing view
    
    var breadDataEntry = 0.0//Data entries being initialized
    var meatDataEntry = 0.0
    var cheeseDataEntry = 0.0
    var vegetableDataEntry = 0.0
    var condimentDataEntry = 0.0
    var utensilDataEntry = 0.0
    var capDataEntry = 0.0
    var cupDataEntry = 0.0
    var napkinaspDataEntry = 0.0
    var chemicalDataEntry = 0.0
    var toiletriesDataEntry = 0.0
    var cleaningtoolDataEntry = 0.0
    
    var numberOfSubCats: [Double] = []//array of different data entries
    var numberOfSubCatsLabels: [String] = []//array of labels for data entries

    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()//updating data values
        
        
        pieChart.delegate = self
        
        pieChart.chartDescription?.text = "Sub-Categories"
        //populating arrays
        numberOfSubCats = [breadDataEntry, meatDataEntry, cheeseDataEntry, vegetableDataEntry, condimentDataEntry, utensilDataEntry, capDataEntry, cupDataEntry, napkinaspDataEntry, chemicalDataEntry, toiletriesDataEntry, cleaningtoolDataEntry]
        numberOfSubCatsLabels = ["Breads", "Meats", "Cheeses", "Vegetables", "Condiments", "Utensils", "Containers and Plates", "Cups", "Napkins and Sauce Packs", "Chemicals", "Toiletries", "Cleaning Tools"]
        
        setChart(dataPoints: numberOfSubCatsLabels,values: numberOfSubCats)//building the chart
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")//fetching items
                
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let subCategory = (data.value(forKey: "sub_category") as! String)//fetching sub category labels
                
                switch subCategory {//for each instance of a subcategory add one to the data value
                    case "breads":
                       breadDataEntry = breadDataEntry + 1
                       break
                    case "meats":
                       meatDataEntry = meatDataEntry + 1
                       break
                    case "cheeses":
                       cheeseDataEntry = cheeseDataEntry + 1
                       break
                    case "vegetables":
                       vegetableDataEntry = vegetableDataEntry + 1
                       break
                    case "condiments":
                       condimentDataEntry = condimentDataEntry + 1
                       break
                    case "utensils":
                       utensilDataEntry = utensilDataEntry + 1
                       break
                    case "containers and plates":
                       capDataEntry = capDataEntry + 1
                       break
                    case "cups":
                       cupDataEntry = cupDataEntry + 1
                       break
                    case "napkins and sauce packs":
                       napkinaspDataEntry = napkinaspDataEntry + 1
                       break
                    case "chemicals":
                       chemicalDataEntry = chemicalDataEntry + 1
                       break
                    case "toiletries":
                       toiletriesDataEntry = toiletriesDataEntry + 1
                       break
                    default:
                       cleaningtoolDataEntry = cleaningtoolDataEntry + 1
                       break
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)//build chart in view
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var dataEntries: [PieChartDataEntry] = []
        //set data entries to a barchartdataset
        for i in 0..<dataPoints.count {//adding each data that is above zero to the chart display
            
            if values[i] > 0 {
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
                dataEntries.append(dataEntry)
            }
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "Sub-Categories")
        chartDataSet.colors = ChartColorTemplates.colorful()

        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.drawEntryLabelsEnabled = false

        pieChart.data = chartData
    }
    



}
