//
//  GrowingTextView.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 15/03/2022.
//

import UIKit

protocol GrowingTextViewDelegate: AnyObject {
//    func heightDidChange(to height: CGFloat)
    func growingTextView(_ growingTextView: GrowingTextView, heightDidChangeTo hight: CGFloat)
}

class GrowingTextView: PlaceholderTextView {
    
    weak var growingTextViewDelegate: GrowingTextViewDelegate?
    
    var maxHight: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        isScrollEnabled = false
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        let width = bounds.width
        
        let newSize = sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        let newHight = newSize.height
        
        let finalHeight = newHight > maxHight ? maxHight : newHight
        
        isScrollEnabled = newHight > maxHight
        
        growingTextViewDelegate?.growingTextView(self, heightDidChangeTo: finalHeight)
    }
    
}
