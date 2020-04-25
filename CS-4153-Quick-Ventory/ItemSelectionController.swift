//
//  ItemSelectionController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/25/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class ItemSelectionController: UITableViewController {
    let itemSource = ["Breads", "Meats", "Cheeses", "Vegetables", "Condiments", "Utensils", "Containers and Plates", "Cups", "Napkins and Sauce Packets", "Chemicals", "Toiletries", "Cleaning Tools"]
    
    let itemImage = [UIImage(named: "breads"), UIImage(named: "meats"), UIImage(named: "cheeses"), UIImage(named: "vegetables"), UIImage(named: "condiments"), UIImage(named: "utensils"), UIImage(named: "platescontainers"), UIImage(named: "cups"), UIImage(named: "saucenapkin"), UIImage(named: "chemicals"), UIImage(named: "toiletries"), UIImage(named: "cleaningtools")]
    
    
    var selectionToPass: String!
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove UITableView separator line
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableView.register(ItemSelectionCell.self, forCellReuseIdentifier: "ItemSelectionCell")
        
        itemTableView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)

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
        return itemImage.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSelectionCell", for: indexPath) as! ItemSelectionCell
        // Configure the cell...
            cell.itemLabel?.text = itemSource[indexPath[1]]
            cell.itemImageView?.image = itemImage[indexPath[1]]
            cell.itemLabel?.isHidden = true
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
         let currentCell = tableView.cellForRow(at: indexPath) as! ItemSelectionCell
         
         selectionToPass = currentCell.itemLabel!.text
         performSegue(withIdentifier: "ToNewProduct", sender: self)
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToNewProduct") {
            
            let viewController = segue.destination as! NewProductController
            
            viewController.selectedImage = selectionToPass
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
