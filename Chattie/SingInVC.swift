//
//  SingInVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 08/03/2022.
//

import UIKit

class SingInVC: UITableViewController {

    
    @IBAction func didTapSingIn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segue.Auth.signInToApp", sender: nil)
        
    }
    
    
}
