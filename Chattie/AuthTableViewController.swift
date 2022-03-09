//
//  AuthTableViewController.swift
//  Chattie
//
//  Created by Kamil Niemczyk on 09/03/2022.
//

import UIKit

class AuthTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)
        guard indexPath.row == 0 else { return defaultHeight}
        let firstRowHeight = tableView.bounds.height * 0.4
        
        return firstRowHeight
    }
   
}
