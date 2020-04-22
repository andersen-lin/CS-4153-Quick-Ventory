//
//  ModifyController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Andersen Lin on 4/12/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

class ModifyController: UIViewController {

    var passedProduct: [String]!
    var deltaQuantity: Int = 0 {
        willSet {
            if (newValue >= 0) {
                quantity.text = "+" + String(newValue)
            } else {
                quantity.text = String(newValue)
            }
        }
    }
    
    @IBOutlet weak var productInfo: UILabel!
    @IBOutlet weak var categoryInfo: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productInfo.text = passedProduct[0]
        categoryInfo.text = passedProduct[1]
    }
 
    @IBAction func addProduct(_ sender: Any) {
        deltaQuantity += 1
    }
    
    @IBAction func deductProduct(_ sender: Any) {
        deltaQuantity -= 1
    }

    @IBAction func deleteProduct(_ sender: UIButton) {
        
        showSimpleAlert()
        
    }
    
    func showSimpleAlert() { //shows an alert confirming the addition of an item
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to all \(passedProduct[0]) items from your inventory?", preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) {
            UIAlertAction in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item") //fetching items
                    
            do {
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    let itemName = (data.value(forKey: "name") as! String)
                    if itemName == self.passedProduct[0] {
                        managedContext.delete(data)
                    }
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }catch {
                print("Failed")
            }
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)//Cancel Action
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            return//Cancel Action
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
