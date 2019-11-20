//
//  AddressFormViewController.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class AddressFormViewController: BaseTableViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = AddressFormViewModel()
    
    override func viewDidLoad() {
            self.initControls()
        }
        
    override func initCell(_ cell: FormTableViewCell, indexPath: IndexPath) {

        super.initCell(cell, indexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            self.populateCell(cell, withTitle: "Country")
        case 1:
            self.populateCell(cell, withTitle: "Locality")
        case 2:
            self.populateCell(cell, withTitle: "Street")
        case 3:
            self.populateCell(cell, withTitle: "House number")
        case 4:
            self.populateCell(cell, withTitle: "Flat number")
        case 5:
            self.populateCell(cell, withTitle: "Postcode")
        default:
            cell.titleLbl.text = ""
            cell.valueTextField.text = ""
        }
    }
    
    override func save() {
        self.viewModel.save {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddressFormViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormTableViewCell",
                                                 for: indexPath) as? FormTableViewCell ??
            FormTableViewCell(style: .default, reuseIdentifier: "FormTableViewCell")

        self.initCell(cell, indexPath: indexPath)
        return cell
    }
}

extension AddressFormViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 0:
            self.viewModel.country = textField.text ?? ""
        case 1:
            self.viewModel.locality = textField.text ?? ""
        case 2:
            self.viewModel.street = textField.text ?? ""
        case 3:
            self.viewModel.houseNumber = textField.text ?? ""
        case 4:
            self.viewModel.flatNumber = textField.text ?? ""
        case 5:
            self.viewModel.postcode = textField.text ?? ""

        default:
            self.viewModel.country = textField.text ?? ""
        }
    }
}

