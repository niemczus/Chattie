//
//  TableViewExtensions.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 17/03/2022.
//

import UIKit

extension UITableView {
    
    func scrollToBottom() {
     
        DispatchQueue.main.async {
            let section = self.numberOfSections - 1
            let row = self.numberOfRows(inSection: section) - 1
            
            if section >= 0 && row >= 0 {
                let bottomIndexPath = IndexPath(row: row, section: section)
                self.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
            }
        }
    }
}
