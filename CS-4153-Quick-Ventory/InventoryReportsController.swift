//
//  InventoryReportsController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class InventoryReportsController: UIViewController {

    
    
    @IBOutlet var chartTypeButtons: [UIButton]!
    @IBOutlet weak var chartSelectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleSelectionCategory(_ sender: UIButton) { //dropdown menu feature
        chartTypeButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: { //animates drop down
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded() //method to fix view coming in from top of screen, has it come from bottom of activator button
            })
        }
    }
    

}
