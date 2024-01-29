//
//  SettingsViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch {
            print(error)
        }
    }
    
}
