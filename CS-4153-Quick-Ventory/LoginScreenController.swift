//
//  LoginScreenController.swift
//  CS-4153-Quick-Ventory
//
//  Created by jacob mathews on 4/5/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData


class CellClassv2: UITableViewCell {
    
}


class LoginScreenController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var btnRest: UIButton!
    @IBOutlet weak var eUN: UITextField!
    @IBOutlet weak var ePW: UITextField!
    
    //Dropdown
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        /* Tapping outside input dismisses keyboard. */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        eUN.delegate = self
        ePW.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClassv2.self, forCellReuseIdentifier: "Cell")
       
        loadRests()
        
    }
    
    
    func loadRests(){
           // Do any additional setup after loading the view.
           
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
           
        do {
            let result = try context.fetch(fetchReq)
            for data in result as! [NSManagedObject] {
                dataSource.append( data.value(forKey: "name") as! String )
            }
        } catch {
            print("Failed")
        }
    }
      
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign keyboard after return. 
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if btnRest.titleLabel?.text == "" {
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
            let restPred = NSPredicate(format: "userToRest.name == %@", btnRest.titleLabel?.text! ?? "")
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
                    
                    //Save user login data
                    UserDefaults.standard.set((btnRest.titleLabel?.text! ?? "") + ";" +  (eUN.text ?? ""), forKey: "login")
                    
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

    
    @IBAction func btnOnClickRest(_ sender: UIButton) {
        selectedButton = btnRest
        addTransparentView(frames: btnRest.frame)
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    
}






extension LoginScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
