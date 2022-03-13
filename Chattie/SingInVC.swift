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
    
    func singIn() {
        
        guard
            let email = emailTextField.text,
            email.isValidEmail,
            let password = passwordTextField.text,
            password.count > 3
        else { showInvalidFormAlert(); return}
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, authError in
            if let error = authError {
                print(error)
                self.showInvalidFormAlert(with: error.localizedDescription)
            }
            
            if
                let result = authResult,
                let chattieUser = ChattieUser(firbaseUser: result.user)
            {
            
                self.performSegue(withIdentifier: "segue.Auth.signInToApp", sender: chattieUser)
            }
        }
    }
    
    
    @IBAction func didTapSingIn(_ sender: UIButton) {
        singIn()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        standardSegueToApp(segue: segue, sender: sender)
    }
}
