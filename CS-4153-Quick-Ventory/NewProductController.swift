//
//  NewProductController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/8/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

class NewProductController: UIViewController, UITextFieldDelegate {
    @IBOutlet var broadCategories: [UIButton]! //declaring buttons
    @IBOutlet weak var broadCatButton: UIButton!
    
    @IBOutlet var foodAndBevCategories: [UIButton]!
    @IBOutlet weak var foodAndBevButton: UIButton!
    @IBOutlet weak var foodAndBevCatButton: UIButton!
    @IBOutlet weak var breadButton: UIButton!
    @IBOutlet weak var meatButton: UIButton!
    @IBOutlet weak var cheeseButton: UIButton!
    @IBOutlet weak var veggieButton: UIButton!
    @IBOutlet weak var condButton: UIButton!
    
    @IBOutlet var tableWareCategories: [UIButton]!
    @IBOutlet weak var tableWareCatButton: UIButton!
    @IBOutlet weak var tableWareButton: UIButton!
    @IBOutlet weak var utensilsButton: UIButton!
    @IBOutlet weak var cAndPButton: UIButton!
    @IBOutlet weak var cupButton: UIButton!
    @IBOutlet weak var nappiesAndSauciesButton: UIButton!
    
    @IBOutlet var cleaningSuppliesCategories: [UIButton]!
    @IBOutlet weak var cleaningSupplyCatButton: UIButton!
    @IBOutlet weak var cleaningSuppliesButton: UIButton!
    @IBOutlet weak var chemicalButton: UIButton!
    @IBOutlet weak var toiletButton: UIButton!
    @IBOutlet weak var cleaningToolButton: UIButton!
    
    @IBOutlet weak var productName: UITextField! //text entry field
    
    public var categorySelection :String = "" //holders for user selection
    public var subCategorySelection : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodAndBevCatButton.isHidden = true //hiding buttons on open
        tableWareCatButton.isHidden = true
        cleaningSupplyCatButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self.view, action:  #selector(UIView.endEditing)) //this kills the keyboard
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        productName.delegate = self
    }
    
    
    
    @IBAction func addItemBtn(_ sender: UIButton) { //saves the item
        saveItem()
        showSimpleAlert()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //returns text field
        // Resign keyboard after return.
        textField.resignFirstResponder()
        return true
    }
    
    func saveItem(){
        // Do any additional setup after loading the view.
        guard let itemName = productName.text else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let itemEntity = NSEntityDescription.entity(forEntityName: "Item", in:context)!
        
        let item = NSManagedObject(entity: itemEntity, insertInto: context)
        
        item.setValue(productName.text, forKey: "name") //inserts item using given and selected info
        item.setValue(categorySelection, forKey: "category")
        item.setValue(subCategorySelection, forKey: "sub_category")
        item.setValue(categorySelection, forKey: "category_image_name")
        item.setValue(subCategorySelection, forKey: "sub_category_image_name")

        // Initialize a quantity value for the new item
        let stockEntity = ItemStock(context: context)
        stockEntity.qty = 1
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchReq.predicate = NSPredicate(format: "name == \"" + productName.text! + "\"")
        do {
            let result = try context.fetch(fetchReq)
            for data in result as! [Item] { // Should be only one record for a item
                stockEntity.stockToItem = data
            }
        } catch {
            print("Cannot load data: \(error)")
        }
        
        do {
           try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func handleSelectionCategory(_ sender: UIButton) { //dropdown menu feature
        broadCategories.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: { //animates drop down
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded() //method to fix view coming in from top of screen, has it come from bottom of activator button
            })
        }
    }
    
    
    @IBAction func handleFoodandBeverage(_ sender: UIButton) {
        foodAndBevCategories.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: { //animates drop down
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded() //method to fix view coming in from top of screen, has it come from bottom of activator button
            })
        }
    }
    
    @IBAction func handleCleaningSupplies(_ sender: UIButton) {
        cleaningSuppliesCategories.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: { //animates drop down
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded() //method to fix view coming in from top of screen, has it come from bottom of activator button
            })
        }
    }
    
    @IBAction func handleTableWare(_ sender: UIButton) {
        tableWareCategories.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: { //animates drop down
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded() //method to fix view coming in from top of screen, has it come from bottom of activator button
            })
        }
    }
    
    enum broadCats: String {
        case foodBeverage = "Food & Beverage" //declaring cases
        case tableware = "Tableware"
        case cleaningSupplies = "Cleaning Supplies"
    }
    
    @IBAction func broadCatTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let broadCat = broadCats(rawValue: title) else {
            return
        }
        switch broadCat {
        case .foodBeverage: //hides all other buttons, displays chosen case
            foodAndBevCatButton.isHidden = false
            tableWareCatButton.isHidden = true
            cleaningSupplyCatButton.isHidden = true
            categorySelection = "food and beverage"
            
        case .tableware:
            tableWareCatButton.isHidden = false
            cleaningSupplyCatButton.isHidden = true
            foodAndBevCatButton.isHidden = true
            categorySelection = "tableware"

        default:
            cleaningSupplyCatButton.isHidden = false
            foodAndBevCatButton.isHidden = true
            tableWareCatButton.isHidden = true
            categorySelection = "cleaning supplies"
        }
        foodAndBevButton.isHidden = true
        tableWareButton.isHidden = true
        broadCatButton.isHidden = true
        cleaningSuppliesButton.isHidden = true
// will handle individual categories when tapped
    }
    
    enum foodAndBevs: String {
        case breads = "Breads"
        case meats = "Meats"
        case cheeses = "Cheeses"
        case vegetables = "Vegetables"
        case condiments = "Condiments"
    }
    @IBAction func foodAndBevTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let foodAndBev = foodAndBevs(rawValue: title) else {
            return
        }
        
        switch foodAndBev { //marks the subcategory holder with the subcategory tapped
        case .breads:
            subCategorySelection = "breads"
        case .meats:
            subCategorySelection = "meats"
        case .cheeses:
            subCategorySelection = "cheeses"
        case .vegetables:
            subCategorySelection = "vegetables"
        case .condiments:
            subCategorySelection = "condiments"
        default:
            return
        }
        hideSubCat()
    }
    
    enum tableWares: String {
        case utensils = "Utensils"
        case containersAndPlates = "Containers and Plates"
        case cups = "Cups"
        case napkinsAndSaucePacks = "Napkins and Sauce Packs"
    }
    @IBAction func tableWareTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let tableWare = tableWares(rawValue: title) else {
            return
        }
        
        switch tableWare {//marks the subcategory holder with the subcategory tapped
        case .utensils:
            subCategorySelection = "utensils"
        case .containersAndPlates:
            subCategorySelection = "containers and plates"
        case .cups:
            subCategorySelection = "cups"
        case .napkinsAndSaucePacks:
            subCategorySelection = "napkins and sauce packs"
        default:
            return
        }
        hideSubCat()
    }
    
    enum cleaningSupplies: String {
        case chemicals = "Chemicals"
        case toiletries = "Toiletries"
        case cleaningTools = "Cleaning Tools"
    }
    
    @IBAction func cleaningSuppliesTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let cleaningSupply = cleaningSupplies(rawValue: title) else {
            return
        }
        
        switch cleaningSupply {//marks the subcategory holder with the subcategory tapped
        case .chemicals:
            subCategorySelection = "chemicals"
        case .toiletries:
            subCategorySelection = "toiletries"
        case .cleaningTools:
            subCategorySelection = "cleaning tools"
        default:
            return
        }
        hideSubCat()
    }
    
    func showSimpleAlert() { //shows an alert confirming the addition of an item
        let alert = UIAlertController(title: "Success", message: "Item has been successfully added to the inventory", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)

            self.dismiss(animated: true, completion: nil)//Cancel Action
        }))

        self.present(alert, animated: true, completion: nil)
    }
    func hideSubCat() {
        breadButton.isHidden = true
        meatButton.isHidden = true
        cheeseButton.isHidden = true
        veggieButton.isHidden = true
        condButton.isHidden = true
        utensilsButton.isHidden = true
        cAndPButton.isHidden = true
        cupButton.isHidden = true
        nappiesAndSauciesButton.isHidden = true
        chemicalButton.isHidden = true
        cleaningToolButton.isHidden = true
        toiletButton.isHidden = true
    }
}
