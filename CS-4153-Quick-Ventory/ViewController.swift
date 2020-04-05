//
//  ViewController.swift
//  CS-4153-Quick-Ventory
//
//  Created by Andersen Lin on 4/4/20.
//  Copyright © 2020 Oklahoma State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var userProfileButton: UIButton!
    
    @IBOutlet weak var newInventoryItemButton: UIButton!
    @IBOutlet weak var inventoryItemsButton: UIButton!
    @IBOutlet weak var inventoryReportsButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
   
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true // hiding the navigation bar
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.topViewController != self) {
            navigationController?.navigationBar.isHidden = false //redisplaying the navigation bar when the VC is changed
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

