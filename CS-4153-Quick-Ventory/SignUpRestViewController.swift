//
//  SignUpRestViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Nathan Zimmer on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

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
        saveRest()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign keyboard after return.
        textField.resignFirstResponder()
        return true
    }
    
    
    func saveRest(){
        // Do any additional setup after loading the view.
        guard let restName = eName.text else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let restEntity = NSEntityDescription.entity(forEntityName: "Restaurant", in:context)!
        
        let rest = NSManagedObject(entity: restEntity, insertInto: context)
        
        rest.setValue(eName.text, forKey: "name")
        rest.setValue(eAdd1.text, forKey: "address1")
        rest.setValue(eAdd2.text, forKey: "address2")
        rest.setValue(eCity.text, forKey: "city")
        rest.setValue(eState.text, forKey: "state")
        rest.setValue(eCountry.text, forKey: "country")
        rest.setValue(eZip.text, forKey: "zip")
        
        do {
           try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
