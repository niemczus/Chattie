//
//  RoundedButton.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 09/03/2022.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
    }
}
