//
//  SingUpVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 08/03/2022.
//

import UIKit

class SingUpVC: UITableViewController {

    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue.Auth.singUpToApp", sender: nil)
    }
    
        
}
