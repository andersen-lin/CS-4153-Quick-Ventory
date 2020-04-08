//
//  SignUpController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var btnRest: UIButton!
    @IBOutlet weak var btnEmp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


            btnEmp.backgroundColor = UIColor(red: 0.46, green: 0.11, blue: 0.11, alpha: 1.0)
        
        // Do any additional setup after loading the view.
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
