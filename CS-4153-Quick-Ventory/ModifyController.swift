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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item") //fetching items
                
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let itemName = (data.value(forKey: "name") as! String)
                if itemName == passedProduct[0] {
                    managedContext.delete(data)
                    showSimpleAlert()
                    
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
        
    }
    
    func showSimpleAlert() { //shows an alert confirming the addition of an item
        let alert = UIAlertController(title: "Success", message: "Items matching name: \(passedProduct[0]) have been deleted from the inventory", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)

            self.dismiss(animated: true, completion: nil)//Cancel Action
        }))

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
