//
//  NewProductController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/8/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class NewProductController: UIViewController {
    @IBOutlet var broadCategories: [UIButton]!
   
    @IBOutlet var foodAndBevCategories: [UIButton]!
    @IBOutlet weak var foodAndBevButton: UIButton!
    
    @IBOutlet var tableWareCategories: [UIButton]!
    @IBOutlet weak var tableWareButton: UIButton!
    
    
    @IBOutlet var cleaningSuppliesCategories: [UIButton]!
    @IBOutlet weak var cleaningSuppliesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodAndBevButton.isHidden = true
        tableWareButton.isHidden = true
        cleaningSuppliesButton.isHidden = true
        // Do any additional setup after loading the view.
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
        case .tableware:
            tableWareButton.isHidden = false
            cleaningSuppliesButton.isHidden = true
            foodAndBevButton.isHidden = true
        case .cleaningSupplies:
            cleaningSuppliesButton.isHidden = false
            foodAndBevButton.isHidden = true
            tableWareButton.isHidden = true
        default:
            return
            
        }
// will handle individual categories when tapped
    }
}
