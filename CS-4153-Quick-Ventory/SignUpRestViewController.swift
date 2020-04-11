//
//  SignUpRestViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Nathan Zimmer on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class SignUpRestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eName: UITextField!
    @IBOutlet weak var eAdd1: UITextField!
    @IBOutlet weak var eAdd2: UITextField!
    @IBOutlet weak var eCity: UITextField!
    @IBOutlet weak var eState: UITextField!
    @IBOutlet weak var eCountry: UITextField!
    @IBOutlet weak var eZip: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* Tapping outside input dismisses keyboard. */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        eName.delegate = self
        eAdd1.delegate = self
        eAdd2.delegate = self
        eCity.delegate = self
        eState.delegate = self
        eCountry.delegate = self
        eZip.delegate = self

        
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
