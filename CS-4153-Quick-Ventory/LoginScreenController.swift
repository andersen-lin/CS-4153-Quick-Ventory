//
//  LoginScreenController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class LoginScreenController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var eRest: UITextField!
    @IBOutlet weak var eUN: UITextField!
    @IBOutlet weak var ePW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        /* Tapping outside input dismisses keyboard. */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        eRest.delegate = self
        eUN.delegate = self
        ePW.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign keyboard after return. 
        textField.resignFirstResponder()
        return true
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
