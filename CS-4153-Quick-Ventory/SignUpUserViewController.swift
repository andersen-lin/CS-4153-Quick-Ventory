//
//  SignUpUserViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Nathan Zimmer on 4/10/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit



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
        
    }
    

    @IBAction func btnNext(_ sender: UIButton) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign keyboard after return.
        textField.resignFirstResponder()
        return true
    }
    
    //onClick
    @IBAction func cbRest(_ sender: Any) {
         dataSource = ["Apple", "Mango", "Orange"]
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
