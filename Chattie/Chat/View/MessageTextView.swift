//
//  MessageTextView.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 15/03/2022.
//

import UIKit

class MessageTextView: GrowingTextView {

    override func setupView() {
        super.setupView()
        
        layer.cornerRadius = 10
        placeholderLabel.text = "Enter the message"
    }
}
