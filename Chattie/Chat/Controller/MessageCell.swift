//
//  MessageCell.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 16/03/2022.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageStyleView: MessageStyleView!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func populate (with message: Message, isFromCurrentUser: Bool) {
        usernameLabel.text = message.sender
        bodyLabel.text = message.body
        messageStyleView.setupView()
        
        contentStackView.alignment = isFromCurrentUser ? .trailing : .leading
        let style: MessageStyle = isFromCurrentUser ? .sent : .recived
        messageStyleView.design(as: style)
    }
  
}
