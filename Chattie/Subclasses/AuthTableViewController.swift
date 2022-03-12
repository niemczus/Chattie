//
//  AuthTableViewController.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 09/03/2022.
//

import UIKit

class AuthTableViewController: UITableViewController {
    
    func showInvalidFormAlert(with message: String? = nil) {
        let alertMessage = message ?? "Please enter valid information below."
        let alert = UIAlertController(title: "Invalid info", message: alertMessage, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Understand", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)
        guard indexPath.row == 0 else { return defaultHeight}
        let firstRowHeight = tableView.bounds.height * 0.4
        
        return firstRowHeight
    }
   
}
