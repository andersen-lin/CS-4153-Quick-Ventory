//
//  ModifyController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Andersen Lin on 4/12/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class ModifyController: UIViewController {

    var passedCategory: [String]!
    
    @IBOutlet weak var categoryInfo: UILabel!
    @IBOutlet weak var broadCategoryInfo: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryInfo.text = passedCategory[1]
        broadCategoryInfo.text = passedCategory[0]
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
