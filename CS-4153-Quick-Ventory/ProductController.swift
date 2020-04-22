//
//  ProductController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/14/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

class ProductController: UITableViewController {

    var dataSource: [NSManagedObject] = []
    
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    
    var passedCategory: String!
    var productToPass: String!
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        
        self.tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
        productTableView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        
        // Fetch the database contents
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        let predicate: NSPredicate
        
        switch (passedCategory) {
        case "Breads":
            predicate = NSPredicate(format: "sub_category == \"breads\"")
        case "Meats":
            predicate = NSPredicate(format: "sub_category == \"meats\"")
        case "Cheeses":
            predicate = NSPredicate(format: "sub_category == \"cheeses\"")
        case "Vegetables":
            predicate = NSPredicate(format: "sub_category == \"vegetables\"")
        case "Condiments":
            predicate = NSPredicate(format: "sub_category == \"condiments\"")
        case "Utensils":
            predicate = NSPredicate(format: "sub_category == \"utensils\"")
        case "Containers and Plates":
            predicate = NSPredicate(format: "sub_category == \"containers and plates\"")
        case "Cups":
            predicate = NSPredicate(format: "sub_category == \"cups\"")
        case "Napkins and Sauce Packets":
            predicate = NSPredicate(format: "sub_category == \"napkins and sauce packs\"")
        case "Chemicals":
            predicate = NSPredicate(format: "sub_category == \"chemicals\"")
        case "Toiletries":
            predicate = NSPredicate(format: "sub_category == \"toiletries\"")
        case "Cleaning Tools":
            predicate = NSPredicate(format: "sub_category == \"cleaning tools\"")
        default:
            return
        }
        fetchRequest.predicate = predicate
        
        do {
            dataSource = try context?.fetch(fetchRequest) ?? []
        } catch let error as NSError {
            print("Cannot load data: \(error)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        // Configure the cell...
        cell.ProductLabel?.text = dataSource[indexPath[1]].value(forKey: "name") as? String
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

          // Get Cell Label
          let indexPath = tableView.indexPathForSelectedRow!
          let currentCell = tableView.cellForRow(at: indexPath) as! ProductCell
          
          productToPass = currentCell.ProductLabel!.text!
          performSegue(withIdentifier: "ToModify", sender: self)
      }
      
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if (segue.identifier == "ToModify") {
             
             let viewController = segue.destination as! ModifyController
             
             viewController.passedProduct = [productToPass, passedCategory]
         }
     }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
