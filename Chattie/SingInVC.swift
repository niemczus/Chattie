//
//  SingInVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 08/03/2022.
//

import UIKit
import FirebaseAuth

class SingInVC: AuthTableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func didTapSingIn(_ sender: UIButton) {
        performSegue(withIdentifier: "segue.Auth.signInToApp", sender: nil)
    }
    
}
