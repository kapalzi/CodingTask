//
//  EmployeeFormViewController.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class EmployeeFormViewController: BaseTableViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = EmployeeFormViewModel()
    
    override func viewDidLoad() {
        
        self.initControls()
    }
    
    override func initCell(_ cell: FormTableViewCell, indexPath: IndexPath) {

        super.initCell(cell, indexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            self.populateCell(cell, withTitle: "First name")
        case 1:
            self.populateCell(cell, withTitle: "Last name")
        case 2:
            self.populateCell(cell, withTitle: "Age")
            cell.valueTextField.isEnabled = false
        case 3:
            self.populateCell(cell, withTitle: "Gender")
        default:
            cell.titleLbl.text = ""
            cell.valueTextField.text = ""
        }
    }
    
    private func initAddressCell(_ cell: EmployeeFormAddressTableViewCell, indexPath: IndexPath) {

        let addressNumber = indexPath.row - self.viewModel.getAddressesCount() - 1
        if self.isLastCell(atRow: indexPath.row) {
            cell.titleLbl.text = "Add Address"
        } else {
            cell.titleLbl.text = "Address \(addressNumber)"
        }
    }
    
    private func isLastCell(atRow row: Int) -> Bool {
        return self.tableView.numberOfRows(inSection: 0) == row + 1
    }
    
    @objc override func save() {
        
    }
}

extension EmployeeFormViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 + self.viewModel.getAddressesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 3  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeFormAddressTableViewCell",
                                                     for: indexPath) as? EmployeeFormAddressTableViewCell ??
                EmployeeFormAddressTableViewCell(style: .default, reuseIdentifier: "EmployeeFormAddressTableViewCell")

            self.initAddressCell(cell, indexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormTableViewCell",
                                                 for: indexPath) as? FormTableViewCell ??
            FormTableViewCell(style: .default, reuseIdentifier: "FormTableViewCell")

        self.initCell(cell, indexPath: indexPath)
        return cell
    }
    
}

extension EmployeeFormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            //show age
        }
        
        if self.isLastCell(atRow: indexPath.row) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddressFormViewController") as! AddressFormViewController
            vc.viewModel.setEntryMode(.create)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EmployeeFormViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 0:
            self.viewModel.firstName = textField.text ?? ""
        case 1:
            self.viewModel.lastName = textField.text ?? ""
        case 2:
            self.viewModel.age = Int16(textField.text ?? "0") ?? 0
        case 3:
            self.viewModel.gender = Int16(textField.text ?? "0") ?? 0
        default:
            self.viewModel.firstName = textField.text ?? ""
        }
    }
}
