//
//  MessagesVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 12/03/2022.
//

import UIKit
import FirebaseAuth

class MessagesVC: UIViewController {
    
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    
    var chattieUser: ChattieUser!

    override func viewDidLoad() {
        super.viewDidLoad()

//        print("ChattieUser from messages")
//        print(chattieUser ?? "none")
    
        addObservers()
    }
    
    func addObservers() {
        
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                                   object: nil,
                                                   queue: .main,
                                                   using: keyboardWillShow)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillHide)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let bottomInset = view.safeAreaInsets.bottom
        let keyboardHight = keyboardFrame.cgRectValue.height
        
        chatContainerViewBottomConstraint.constant = keyboardHight - bottomInset
        
//        UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        chatContainerViewBottomConstraint.constant = 0
    }
    
    @IBAction func didTapSignOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "segue.Chat.messegesToSignIn", sender: nil)
        } catch {
            print(error)
        }
    }
}
