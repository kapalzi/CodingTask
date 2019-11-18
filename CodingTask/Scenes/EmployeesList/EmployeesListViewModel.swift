//
//  EmployeesListViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 19/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//
import UIKit

class EmployeesListViewModel {
    
    private var employees: [Employee]!
    
    func getAllEmployees(completionHandler: @escaping (() -> Void)) {
          
        let context = appDelegate().persistentContainer.viewContext
        
        if let employees = Employee.getAllEmployees(inContext: context) {
            self.employees = employees
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
    
    private func appDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
}
