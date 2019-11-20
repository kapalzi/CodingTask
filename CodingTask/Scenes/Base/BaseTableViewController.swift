//
//  BaseTableViewController.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    func populateCell(_ cell: FormTableViewCell, withTitle title: String) {

        cell.titleLbl.text = title
    }
    
    func initControls() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func save() {
        
    }
    
    func initCell(_ cell: FormTableViewCell, indexPath: IndexPath) {

        cell.valueTextField.tag = indexPath.row
    }
}