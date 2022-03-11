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
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showInvalidFormAlert(with message: String? = nil) {
        let alertMessage = message ?? "Please enter valid information below."
        let alert = UIAlertController(title: "Invalid info", message: alertMessage, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Understand", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func assign(_ username: String, to firebaseUser: FirebaseAuth.User) {
        let changeRequest = firebaseUser.createProfileChangeRequest()
        changeRequest.displayName = username
        changeRequest.commitChanges { requestError in
            if let unwrappedRequestError = requestError {
                self.showInvalidFormAlert(with: unwrappedRequestError.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "segue.Auth.singUpToApp", sender: nil)
            }
        }
    }
    
    func createUser() {
        guard
            let username = usernameTextField.text,
            username.count > 3,
            let email = emailTextField.text,
            isValid(email),
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
            
            if let authResult = authResult {
                print(authResult.user)
                self.assign(username, to: authResult.user)
            }
        }
        
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        createUser()
    }
     
}
