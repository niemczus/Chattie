//
//  MessagesVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 12/03/2022.
//

import UIKit
import FirebaseAuth

class MessagesVC: UIViewController {
    
    var chattieUser: ChattieUser!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ChattieUser from messages")
        print(chattieUser ?? "none")
    
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
