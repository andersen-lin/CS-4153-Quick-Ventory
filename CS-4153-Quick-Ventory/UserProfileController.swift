//
//  UserProfileController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class UserProfileController: UIViewController {
    

    @IBOutlet weak var lNam: UILabel!
    @IBOutlet weak var lRest: UILabel!
    @IBOutlet weak var lUN: UILabel!
    @IBOutlet weak var lPW: UILabel!
    
    var currentPW = ""
    var rest = ""
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
    }
    
    func loadUser() {
        
       let login = UserDefaults.standard.string(forKey: "login")
       let loginVal = login?.components(separatedBy: ";")
       rest = loginVal?[0] ?? ""
       userName = loginVal?[1] ?? ""
       
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       let context = appDelegate.persistentContainer.viewContext
      
      //fetch request  for CREDS
      let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
      let restPred = NSPredicate(format: "userToRest.name == %@", rest)
      let credPredUN = NSPredicate(format: "userCredR.userName == %@", userName)
      let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [restPred, credPredUN])
      fetchReq.predicate = andPredicate
      
      do {
          
          
          let result = try context.fetch(fetchReq)
          for data in result as! [User] {
           lNam.text = (data.firstName ?? "") + " " + (data.lastName ?? "")
           lRest.text = "Restaurant: " + (data.userToRest?.name ?? "")
           lUN.text = "User Name: " + (data.userCredR?.userName ?? "")
           lPW.text = "Password: ****** "
           currentPW = (data.userCredR?.password ?? "")
           
           }
          
                   
      } catch {
          print("fail")
      }

    }

    @IBAction func onClickChangePW(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change Password", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        })

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Confirm New Password"
            textField.isSecureTextEntry = true
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let currentPass = alert.textFields?.first?.text {
                if let newPass = alert.textFields?[1].text{
                    if let newPassConfirm = alert.textFields?[2].text{
                
                        if currentPass != self.currentPW {
                            let alert =  UIAlertController(title: "Change Password Error", message: "That is not your current password", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }
                        
                        if newPass != newPassConfirm {
                           let alert =  UIAlertController(title: "Change Password Error", message: "Passwords don't match", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        } else {
                            
                            // Change password
                             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                               let context = appDelegate.persistentContainer.viewContext
                              
                              //fetch request  for CREDS
                              let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                              let restPred = NSPredicate(format: "userToRest.name == %@", self.rest)
                              let credPredUN = NSPredicate(format: "userCredR.userName == %@", self.userName)
                              let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [restPred, credPredUN])
                              fetchReq.predicate = andPredicate
                              
                              do {
                                  
                                  
                                  let result = try context.fetch(fetchReq)
                                  for data in result as! [User] {
                                    data.userCredR?.password = newPass
                                   
                                    }
                                  
                                           
                              } catch {
                                  print("fail")
                              }
                            
                            
                            // SAVE
                             do {
                                try context.save()
                             } catch let error as NSError {
                                 print("Could not save. \(error), \(error.userInfo)")
                             }
                            
                            let alert =  UIAlertController(title: "Success!", message: "Your password has successfully been changed", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                        }
                        
                
                    }
                }
            }
        }))

        self.present(alert, animated: true)
        
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
