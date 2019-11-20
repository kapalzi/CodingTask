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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func initCell(_ cell: FormTableViewCell, indexPath: IndexPath) {

        super.initCell(cell, indexPath: indexPath)
        
        if self.viewModel.employee != nil {
            self.initEditCell(cell, indexPath: indexPath)
        } else {
            self.initNewCell(cell, indexPath: indexPath)
        }
    }
    
    private func initNewCell(_ cell: FormTableViewCell, indexPath: IndexPath) {
        
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
            cell.valueTextField.isEnabled = false
        default:
            cell.titleLbl.text = ""
            cell.valueTextField.text = ""
        }
    }
    
    private func initEditCell(_ cell: FormTableViewCell, indexPath: IndexPath) {
        
        guard let employee = self.viewModel.employee else {
            return
        }
        
        switch indexPath.row {
        case 0:
            self.populateEditCell(cell, withTitle: "First name", withValue: employee.firstName ?? "")
        case 1:
            self.populateEditCell(cell, withTitle: "Last name", withValue: employee.lastName ?? "")
        case 2:
            self.populateEditCell(cell, withTitle: "Age", withValue: "\(employee.age)")
        case 3:
            self.populateEditCell(cell, withTitle: "Gender", withValue: "\(employee.gender)")
        default:
            cell.titleLbl.text = ""
            cell.valueTextField.text = ""
        }
    }
    
    private func initAddressCell(_ cell: EmployeeFormAddressTableViewCell, indexPath: IndexPath) {

        let addressNumber = indexPath.row - 3
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
        super.save()
        self.viewModel.save {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAgeAlert() {

        let ac = UIAlertController(title: "Please enter age", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        
        ac.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { (_) in
            let textField = ac.textFields![0] as UITextField
            self.viewModel.age = Int16(textField.text ?? "0") ?? 0
            if let ageTextField = self.view.viewWithTag(2) as? UITextField {
                ageTextField.text = textField.text
            }
        }))
        self.startAlertWithCancel(ac: ac)
    }
    
    private func showGenderAlert() {

        let ac = UIAlertController(title: "Please select gender", message: nil, preferredStyle: .alert)

        let indexes = [0,1,2,9]
        for i in indexes {
            ac.addAction(UIAlertAction(title: Gender(rawValue: i)?.description, style: .default, handler: { (action) in
                self.viewModel.gender = Int16(i)
                if let genderTextField = self.view.viewWithTag(3) as? UITextField {
                    genderTextField.text = action.title
                }
            }))
        }
        self.startAlertWithCancel(ac: ac)
    }
    
    private func startAlertWithCancel(ac: UIAlertController) {
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
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
            self.showAgeAlert()
        }
        
        if indexPath.row == 3 {
            self.showGenderAlert()
        }
        
        if self.isLastCell(atRow: indexPath.row) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddressFormViewController") as! AddressFormViewController
            vc.viewModel.delegate = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row > 3 && !self.isLastCell(atRow: indexPath.row) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddressFormViewController") as! AddressFormViewController
            vc.viewModel.address = self.viewModel.getAddressAtIndex(indexPath.row)
            vc.viewModel.delegate = self.viewModel
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
