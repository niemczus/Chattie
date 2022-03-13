//
//  SingUpVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 08/03/2022.
//

import UIKit
import FirebaseAuth

class SingUpVC: AuthTableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func assign(_ username: String, to firebaseUser: FirebaseAuth.User) {
        let changeRequest = firebaseUser.createProfileChangeRequest()
        changeRequest.displayName = username
        changeRequest.commitChanges { requestError in
            if let unwrappedRequestError = requestError {
                self.showInvalidFormAlert(with: unwrappedRequestError.localizedDescription)
            } else if let chattieUser = ChattieUser(firbaseUser: firebaseUser) {
                self.performSegue(withIdentifier: "segue.Auth.singUpToApp", sender: chattieUser)
            }
        }
    }
    
    func createUser() {
        guard
            let username = usernameTextField.text,
            username.count > 3,
            let email = emailTextField.text,
            email.isValidEmail,
            let password = passwordTextField.text,
            password.count > 5
        else {
            showInvalidFormAlert()
            return
        }
        
        print(username)
        print(email)
        print(password)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, authError in
            
            if let error = authError {
                print(error)
                self.showInvalidFormAlert(with: error.localizedDescription)
            }
            
            if let result = authResult {
                print(result.user)
                self.assign(username, to: result.user)
            }
        }
        
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        createUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        standardSegueToApp(segue: segue, sender: sender)
    }
    
}
