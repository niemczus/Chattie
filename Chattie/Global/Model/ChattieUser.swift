//
//  ChattieUser.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 12/03/2022.
//

import Foundation
import FirebaseAuth

struct ChattieUser {
    
    let id: String
    let userName: String
    let email: String
    
    init?(firbaseUser: FirebaseAuth.User) {
        
        guard
            let displayName = firbaseUser.displayName,
            let email = firbaseUser.email
        else { return nil }
        
        self.id = firbaseUser.uid
        self.userName = displayName
        self.email = email
    }
}

extension ChattieUser: CustomStringConvertible {
    var description: String {
        let chattieUserDescription = """

        id: \(id)
        username: \(userName)
        email: \(email)

        """
        return chattieUserDescription
    }
}
