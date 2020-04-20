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

    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var itemEntity: NSEntityDescription?
    
    let breadsSource = ["White", "Wheat"]
    let meatsSource = ["Beef", "Pork", "Chicken"]
    let cheesesSource = ["American", "Cheddar", "Parmesan", "Swiss"]
    let vegetablesSource = ["Spinach", "Lettuce", "Cucumber"]
    let condimentsSource = ["Mustard", "Mayonaisse", "Ketchup"]
    
    let utensilsSource = ["Spoon", "Knife", "Fork"]
    let conplSource = ["Plate", "Bowl", "To-Go Box"]
    let cupsSource = ["Coffee Cup", "Soda Cup"]
    let napsauSource = ["Napkin", "Sauce Packet"]
    
    let chemSource = ["Detergent", "Sanitizer", "Airspray"]
    let toilSource = ["Soap", "Toothbrush", "Towel"]
    let cleanSource = ["Broom", "Mop", "Bucket"]
    
    let breadsImage = [UIImage(named: "white_bread"), UIImage(named: "wheat_bread")]
    let meatsImage = [UIImage(named: "beef_meat"), UIImage(named: "pork_meat"), UIImage(named: "chicken_meat")]
    let cheeseImage = UIImage(named: "cheeses")
    let vegetablesImage = [UIImage(named: "spinach_vegetable"), UIImage(named: "lettuce_vegetable"), UIImage(named: "cucumber_vegetable")]
    let condimentsImage = [UIImage(named: "mustard_condiment"), UIImage(named: "mayonaisse_condiment"), UIImage(named: "ketchup_condiment")]
    
    let utensilsImage = [UIImage(named: "spoon_utensil"), UIImage(named: "knife_utensil"), UIImage(named: "fork_utensil")]
    let conplImage = [UIImage(named: "plate_conpl"), UIImage(named: "bowl_conpl"), UIImage(named: "takeaway_conpl")]
    let cupsImage = [UIImage(named: "coffee_cup"), UIImage(named: "soda_cup")]
    let napsauImage = [UIImage(named: "napkins"), UIImage(named: "saucepackets")]
    
    let chemImage = [UIImage(named: "detergent_chem"), UIImage(named: "sanitizer_chem"), UIImage(named: "airspray_chem")]
    let toilImage = [UIImage(named: "soap_toil"), UIImage(named: "toothbrush_toil"), UIImage(named: "towel_toil")]
    let cleanImage = [UIImage(named: "broom_clean"), UIImage(named: "mop_clean"), UIImage(named: "bucket_clean")]
    
    var passedCategory: String!
    var productToPass: String!
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        itemEntity = NSEntityDescription.entity(forEntityName: "item", in:context!)
        
        self.tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
        productTableView.delegate = self
        
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
        switch passedCategory {
        case "Breads":
            return breadsSource.count
        case "Meats":
            return meatsSource.count
        case "Cheeses":
            return cheesesSource.count
        case "Vegetables":
            return vegetablesSource.count
        case "Condiments":
            return condimentsSource.count
        case "Utensils":
            return utensilsSource.count
        case "Containers and Plates":
            return conplSource.count
        case "Cups":
            return cupsSource.count
        case "Napkins and Sauce Packets":
            return napsauSource.count
        case "Chemicals":
            return chemSource.count
        case "Toiletries":
            return toilSource.count
        case "Cleaning Tools":
            return cleanSource.count
            
        default:
            return breadsSource.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell

        // Configure the cell...
        switch passedCategory {
        case "Breads":
            cell.ProductLabel?.text =  breadsSource[indexPath[1]]
            cell.ProductImage?.image = breadsImage[indexPath[1]]
        case "Meats":
            cell.ProductLabel?.text =  meatsSource[indexPath[1]]
            cell.ProductImage?.image = meatsImage[indexPath[1]]
        case "Cheeses":
            cell.ProductLabel?.text =  cheesesSource[indexPath[1]]
            cell.ProductImage?.image = cheeseImage
        case "Vegetables":
            cell.ProductLabel?.text =  vegetablesSource[indexPath[1]]
            cell.ProductImage?.image = vegetablesImage[indexPath[1]]
        case "Condiments":
            cell.ProductLabel?.text =  condimentsSource[indexPath[1]]
            cell.ProductImage?.image = condimentsImage[indexPath[1]]
        case "Utensils":
            cell.ProductLabel?.text =  utensilsSource[indexPath[1]]
            cell.ProductImage?.image = utensilsImage[indexPath[1]]
        case "Containers and Plates":
            cell.ProductLabel?.text =  conplSource[indexPath[1]]
            cell.ProductImage?.image = conplImage[indexPath[1]]
        case "Cups":
            cell.ProductLabel?.text =  cupsSource[indexPath[1]]
            cell.ProductImage?.image = cupsImage[indexPath[1]]
        case "Napkins and Sauce Packets":
            cell.ProductLabel?.text =  napsauSource[indexPath[1]]
            cell.ProductImage?.image = napsauImage[indexPath[1]]
        case "Chemicals":
            cell.ProductLabel?.text =  chemSource[indexPath[1]]
            cell.ProductImage?.image = chemImage[indexPath[1]]
        case "Toiletries":
            cell.ProductLabel?.text =  toilSource[indexPath[1]]
            cell.ProductImage?.image = toilImage[indexPath[1]]
        case "Cleaning Tools":
            cell.ProductLabel?.text =  cleanSource[indexPath[1]]
            cell.ProductImage?.image = cleanImage[indexPath[1]]
        default:
            cell.ProductLabel?.text =  "N/A"
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
