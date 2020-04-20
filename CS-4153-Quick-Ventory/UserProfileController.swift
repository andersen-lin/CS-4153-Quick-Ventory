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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let login = UserDefaults.standard.string(forKey: "login")
        let loginVal = login?.components(separatedBy: ";")
        let rest = loginVal?[0] ?? ""
        let userName = loginVal?[1] ?? ""
        
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
            
            
            }
           
                    
       } catch {
           print("fail")
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
