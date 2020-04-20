//
//  ModifyController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Andersen Lin on 4/12/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
