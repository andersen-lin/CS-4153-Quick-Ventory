//
//  SignUpUserViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Nathan Zimmer on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class SignUpUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eFName: UITextField!
    @IBOutlet weak var eLName: UITextField!
    @IBOutlet weak var eUsername: UITextField!
    @IBOutlet weak var ePw: UITextField!
    @IBOutlet weak var ePwConfirm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /* Tapping outside input dismisses keyboard. */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        eFName.delegate = self
        eLName.delegate = self
        eUsername.delegate = self
        ePw.delegate = self
        ePwConfirm.delegate = self
    }
    

    @IBAction func btnNext(_ sender: UIButton) {
        
        
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
