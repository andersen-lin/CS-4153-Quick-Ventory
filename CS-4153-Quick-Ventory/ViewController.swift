//
//  ViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Andersen Lin on 4/4/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData
import Charts

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var userProfileButton: UIButton!
    
    @IBOutlet weak var newInventoryItemButton: UIButton!
    @IBOutlet weak var inventoryItemsButton: UIButton!
    @IBOutlet weak var inventoryReportsButton: UIButton!
    
    @IBOutlet weak var chartView: PieChartView!
    
   //intializing view
    
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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        resetCount()
        retrieveData()//updating data values
        
        
        chartView.delegate = self
        
        chartView.chartDescription?.text = "Sub-Categories"
        //populating arrays
        numberOfSubCats = [breadDataEntry, meatDataEntry, cheeseDataEntry, vegetableDataEntry, condimentDataEntry, utensilDataEntry, capDataEntry, cupDataEntry, napkinaspDataEntry, chemicalDataEntry, toiletriesDataEntry, cleaningtoolDataEntry]
        numberOfSubCatsLabels = ["Breads", "Meats", "Cheeses", "Vegetables", "Condiments", "Utensils", "Containers and Plates", "Cups", "Napkins and Sauce Packs", "Chemicals", "Toiletries", "Cleaning Tools"]
        
        setChart(dataPoints: numberOfSubCatsLabels,values: numberOfSubCats)//building the chart
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        chartView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)//build chart in view
        chartView.center = view.center
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
        chartView.drawEntryLabelsEnabled = false
        let chartData = PieChartData(dataSet: chartDataSet)
                
        chartView.data = chartData
    }//added
    
    func resetCount(){
        breadDataEntry = 0.0//Data entries being initialized
        meatDataEntry = 0.0
        cheeseDataEntry = 0.0
        vegetableDataEntry = 0.0
        condimentDataEntry = 0.0
        utensilDataEntry = 0.0
        capDataEntry = 0.0
        cupDataEntry = 0.0
        napkinaspDataEntry = 0.0
        chemicalDataEntry = 0.0
        toiletriesDataEntry = 0.0
        cleaningtoolDataEntry = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}


