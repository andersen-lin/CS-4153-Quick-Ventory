//
//  CategoryController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class CategoryController: UITableViewController {

    let foodbeverSource = ["Breads", "Meats", "Cheeses", "Vegetables", "Condiments"]
    let testSource = ["xxx", "xxx", "xxx", "xxx", "xxx"]
    let foodbeverImage = [UIImage(named: "breads"), UIImage(named: "meats"), UIImage(named: "cheeses"), UIImage(named: "vegetables"), UIImage(named: "condiments")]
    
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passedValue)
        // Remove UITableView separator line
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        
        // print(passedValue)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch passedValue {
        case "Food and Beverage":
            return foodbeverSource.count
        default:
            return testSource.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        // Configure the cell...
        switch passedValue {
        case "Food and Beverage":
            cell.CategoryLabel?.text =  foodbeverSource[indexPath[1]]
            cell.CategoryImage?.image = foodbeverImage[indexPath[1]]
        default:
            cell.CategoryLabel?.text =  testSource[indexPath[1]]
            cell.CategoryImage?.image = foodbeverImage[indexPath[1]]
        }

        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
