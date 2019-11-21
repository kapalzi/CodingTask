//
//  EmployeesListViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 19/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//
import Foundation

class EmployeesListViewModel: BaseViewModel {

    private var employees: [Employee]!

    func getAllEmployees(completionHandler: @escaping (() -> Void)) {

        let context = appDelegate().persistentContainer.viewContext

        if let employees = Employee.getAllEmployees(inContext: context) {
            self.employees = employees
            completionHandler()
        }
    }

    func getEmployee(forId id: Int16, completionHandler: @escaping ((_ employee: Employee) -> Void), errorHandler: @escaping ((_ error: String) -> Void)) {

         let context = appDelegate().persistentContainer.viewContext

        if let employee = Employee.getEmployee(forId: id, inContext: context) {
            completionHandler(employee)
        } else {
            errorHandler("No employee with given index!")
        }
    }

    func deleteEmployee(index: Int, completionHandler: @escaping (() -> Void)) {

        let employee = self.employeeAtIndex(index: index)
        employee.remove(inContext: appDelegate().persistentContainer.viewContext)
        appDelegate().saveContext()

        self.employees.remove(at: index)
        completionHandler()
    }

    func employeesCount() -> Int {

        return self.employees.count
    }

    func employeeAtIndex(index: Int) -> Employee {

        return self.employees[index]
    }
}
