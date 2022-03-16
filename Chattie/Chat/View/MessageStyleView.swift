//
//  MessegeStyleView.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 16/03/2022.
//

import UIKit

class MessageStyleView: UIView {

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupView() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func design(as messageStyle: MessageStyle) {
        switch messageStyle {
        case .sent:
            backgroundColor = UIColor(named: "chatBubbleGreen")
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor
            
        case .recived:
            backgroundColor = UIColor(named: "chatBubbleGray")
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor

        }
    }
    
}
