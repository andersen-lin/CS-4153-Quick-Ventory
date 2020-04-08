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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func broadCatTapped(_ sender: UIButton) { // will handle individual categories when tapped
    }
}
