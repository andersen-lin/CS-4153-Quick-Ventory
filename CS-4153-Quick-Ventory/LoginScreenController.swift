//
//  LoginScreenController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

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
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if eRest.text == "" {
            let alert =  UIAlertController(title: "Login Error", message: "You must provide a restaurant name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else if eUN.text == "" || ePW.text == "" {
            let alert =  UIAlertController(title: "Login Error", message: "You must provide a username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            //fetch request  for CREDS
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let restPred = NSPredicate(format: "userToRest.name == %@", eRest.text!)
            let credPredUN = NSPredicate(format: "userCredR.userName == %@", eUN.text!)
            let credPredPW = NSPredicate(format: "userCredR.password == %@", ePW.text!)
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [restPred, credPredUN,credPredPW])
            fetchReq.predicate = andPredicate
            
            do {
                
                
                let result = try context.fetch(fetchReq)
                for data in result as! [User] {
                    print(data)
                    print(data.userCredR!.userName)
                    print(data.userCredR!.password)
                    print(data.userToRest?.name)
                }
                
               
                          
                if result.count > 0 {
                    performSegue(withIdentifier: "login", sender: sender)
                    
                } else {
                              let alert =  UIAlertController(title: "Login Error", message: "Invalid Credentials", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                              self.present(alert, animated: true)
                             }
                         
            } catch {
                print("fail")
            }
            
            
          
            
            
          
        }
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
