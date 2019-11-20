//
//  EmployeeFormViewController.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class EmployeeFormViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = EmployeeFormViewModel()
    
    private func initCell(_ cell: EmployeeFormTableViewCell, indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            self.populateCell(cell, withTitle: "First name")
        case 1:
            self.populateCell(cell, withTitle: "Last name")
        case 2:
            self.populateCell(cell, withTitle: "Age")
        case 3:
            self.populateCell(cell, withTitle: "Gender")
        default:
            cell.titleLbl.text = ""
            cell.valueTextField.text = ""
        }
    }
    
    private func populateCell(_ cell: EmployeeFormTableViewCell, withTitle title: String) {

        cell.titleLbl.text = title
    }
}

extension EmployeeFormViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeFormTableViewCell",
                                                 for: indexPath) as? EmployeeFormTableViewCell ??
            EmployeeFormTableViewCell(style: .default, reuseIdentifier: "EmployeeFormTableViewCell")

        self.initCell(cell, indexPath: indexPath)
        return cell
    }
    
}

extension EmployeeFormViewController: UITableViewDelegate {
    
    
}
