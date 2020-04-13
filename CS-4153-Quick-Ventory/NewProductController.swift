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
    @IBOutlet var broadCategories: [UIButton]!
   
    @IBOutlet var foodAndBevCategories: [UIButton]!
    @IBOutlet weak var foodAndBevButton: UIButton!
    
    @IBOutlet var tableWareCategories: [UIButton]!
    @IBOutlet weak var tableWareButton: UIButton!
    
    @IBOutlet var cleaningSuppliesCategories: [UIButton]!
    @IBOutlet weak var cleaningSuppliesButton: UIButton!
    
    
    @IBOutlet weak var productName: UITextField!
    
    public var categorySelection :String = ""
    public var subCategorySelection : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodAndBevButton.isHidden = true
        tableWareButton.isHidden = true
        cleaningSuppliesButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        productName.delegate = self
    }
    
    
    
    @IBAction func addItemBtn(_ sender: UIButton) {
        saveItem()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
        item.setValue(productName.text, forKey: "name")
        item.setValue(categorySelection, forKey: "category")
        item.setValue(subCategorySelection, forKey: "sub_category")
        item.setValue(categorySelection, forKey: "category_image_name")
        item.setValue(subCategorySelection, forKey: "sub_category_image_name")

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
        case foodBeverage = "Food & Beverage"
        case tableware = "Tableware"
        case cleaningSupplies = "Cleaning Supplies"
    }
    
    @IBAction func broadCatTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let broadCat = broadCats(rawValue: title) else {
            return
        }
        switch broadCat {
        case .foodBeverage:
            foodAndBevButton.isHidden = false
            tableWareButton.isHidden = true
            cleaningSuppliesButton.isHidden = true
            categorySelection = "food and beverage"
            
        case .tableware:
            tableWareButton.isHidden = false
            cleaningSuppliesButton.isHidden = true
            foodAndBevButton.isHidden = true
            categorySelection = "tableware"

        case .cleaningSupplies:
            cleaningSuppliesButton.isHidden = false
            foodAndBevButton.isHidden = true
            tableWareButton.isHidden = true
            categorySelection = "cleaning supplies"

        default:
            return
            
        }
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
        
        switch foodAndBev {
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
    }
    
    enum tableWares: String {
        case utensils = "Breads"
        case containersAndPlates = "Meats"
        case cups = "Cheeses"
        case napkinsAndSaucePacks = "Vegetables"
    }
    @IBAction func tableWareTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let tableWare = tableWares(rawValue: title) else {
            return
        }
        
        switch tableWare {
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
        
        switch cleaningSupply {
        case .chemicals:
            subCategorySelection = "chemicals"
        case .toiletries:
            subCategorySelection = "toiletries"
        case .cleaningTools:
            subCategorySelection = "cleaning tools"
        default:
            return
        }
    }
    
}
