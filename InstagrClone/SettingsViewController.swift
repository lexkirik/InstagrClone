//
//  SettingsViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignInVC", sender: nil)
    }
    
}
