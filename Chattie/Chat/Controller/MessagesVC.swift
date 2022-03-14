//
//  MessagesVC.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 12/03/2022.
//

import UIKit

class MessagesVC: UIViewController {
    
    var chattieUser: ChattieUser!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ChattieUser from messages")
        print(chattieUser ?? "none")
    
    }
}
