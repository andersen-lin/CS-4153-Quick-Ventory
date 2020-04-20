//
//  SignUpUserViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Nathan Zimmer on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData


class CellClass: UITableViewCell {
    
}


class SignUpUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eFName: UITextField!
    @IBOutlet weak var eLName: UITextField!
    @IBOutlet weak var eUsername: UITextField!
    @IBOutlet weak var ePw: UITextField!
    @IBOutlet weak var ePwConfirm: UITextField!
    @IBOutlet weak var cbRest: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
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
      
    
    func saveUser(){
        // Do any additional setup after loading the view.
        guard let uFN = eFName.text else { return }
        guard let uLN = eLName.text else { return }
        guard let uUN = eUsername.text else { return }
        guard let uPW = ePw.text else { return }
        guard let uPW2 = ePwConfirm.text else { return }
        guard let uRestName = cbRest.titleLabel?.text else { return }
        if uPW != uPW2 { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let userEntity = User(context: context)
        
        userEntity.firstName = uFN
        userEntity.lastName = uLN
        userEntity.isDarkMode = false
        userEntity.userCredR = UserCredentials(context: context)
        userEntity.userCredR?.userName = uUN
        userEntity.userCredR?.password = uPW
      
        //fetch request  for RESTAURANT ADDITION
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        fetchReq.predicate = NSPredicate(format: "name == %@", uRestName)
        
        do {
            let result = try context.fetch(fetchReq)
            for data in result as! [Restaurant] {
                print(data)
                userEntity.userToRest = data
            }
        } catch {
            print("Failed")
        }
    
    
        
        // SAVE
        do {
           try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        saveUser()        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign keyboard after return.
        textField.resignFirstResponder()
        return true
    }
    
    //onClick
    @IBAction func cbRest(_ sender: Any) {
              selectedButton = cbRest
              addTransparentView(frames: cbRest.frame)
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




extension SignUpUserViewController: UITableViewDelegate, UITableViewDataSource {
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
