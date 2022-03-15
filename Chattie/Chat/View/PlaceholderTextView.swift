//
//  PlaceholderTextView.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 14/03/2022.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    let placeholderLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }
    
    func setupView() {
        delegate = self
        
        placeholderLabel.frame = CGRect(x: 7, y: -8, width: bounds.width, height: bounds.height)
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = font
        
        addSubview(placeholderLabel)
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.text.count != 0
    }
}
