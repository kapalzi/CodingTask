//
//  ViewController.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 18/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class EmployeesListViewController: UIViewController {

    private let viewModel: EmployeesListViewModel = EmployeesListViewModel()
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.initControls()
        self.refreshView()
    }

    private func refreshView() {

        DispatchQueue.main.async {
            self.viewModel.getAllEmployees {
            self.tableView.reloadData()
            }
        }
    }

    private func initControls() {

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddEmployee))
        self.navigationItem.rightBarButtonItem = addButton
    }

    private func initCell(_ cell: EmployeesListTableViewCell, indexPath: IndexPath) {

        let employee = self.viewModel.employeeAtIndex(index: indexPath.row)
        cell.nameLbl.text = "\(employee.firstName ?? "") \(employee.lastName ?? "")"
        cell.ageLbl.text = "\(employee.age)"
    }

    @objc private func showAddEmployee() {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeFormViewController") as! EmployeeFormViewController
        vc.viewModel = EmployeeFormViewModel(employee: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func showDetails(ofEmployee employee: Employee) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeFormViewController") as! EmployeeFormViewController
        vc.viewModel = EmployeeFormViewModel(employee: employee)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func showErrorAlert(withMessage message: String) {

        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(ac, animated: true, completion: nil)
    }

    private func showAgeAlert() {

        let ac = UIAlertController(title: "Enter employee id", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }

        ac.addAction(UIAlertAction(title: "Select", style: .destructive, handler: { (_) in
            let textField = ac.textFields![0] as UITextField

            self.viewModel.getEmployee(forId: Int16(textField.text ?? "0") ?? 0, completionHandler: { (employee) in
                self.showDetails(ofEmployee: employee)
            }) { (errorMessage) in
                self.showErrorAlert(withMessage: errorMessage)
            }
        }))

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }

    @IBAction func searchDidTap(_ sender: UIBarButtonItem) {

        self.showAgeAlert()
    }

}

extension EmployeesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.employeesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeesListTableViewCell",
                                                 for: indexPath) as? EmployeesListTableViewCell ??
            EmployeesListTableViewCell(style: .default, reuseIdentifier: "EmployeesListTableViewCell")

        self.initCell(cell, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
            self.viewModel.deleteEmployee(index: indexPath.row) {
                self.tableView.reloadData()
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])

        return swipeActions
    }
}

extension EmployeesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let employee = self.viewModel.employeeAtIndex(index: indexPath.row)
        self.showDetails(ofEmployee: employee)
    }
}
