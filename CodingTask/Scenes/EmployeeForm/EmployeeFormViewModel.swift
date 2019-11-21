//
//  EmployeeFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class EmployeeFormViewModel: BaseViewModel {
    
    var employee: Employee?
    var firstName: String = ""
    var lastName: String = ""
    var age: Int16 = 0
    var gender: Int16 = 0
    var addresses: Set = Set<Address>()
    
    func getAddressAtIndex(_ index: Int) -> Address? {
        
        if addresses.count > 0 && index > 3 {
            return addresses[addresses.index(addresses.startIndex, offsetBy: index - 4)]
        } else {
            return nil
        }
    }
    
    func getAddressesCount() -> Int {
        return self.addresses.count
    }
    
    func setValuesFromEmployee(_ employee: Employee) {
        self.employee = employee
        self.firstName = employee.firstName ?? ""
        self.lastName = employee.lastName ?? ""
        self.age = employee.age
        self.gender = employee.gender
        self.addresses = employee.addresses as! Set<Address>
    }
    
    func save(completionHandler: @escaping (() -> Void)) {
        
        if let employee = self.employee {
            self.updateEmployee(employee, completionHandler: completionHandler)
        } else {
            self.saveNew(completionHandler: completionHandler)
        }
    }
    
    func saveNew(completionHandler: @escaping (() -> Void)) {
        
        let context = self.appDelegate().persistentContainer.viewContext
        let employee = Employee.createEmployee(firstName: self.firstName,
                                               lastName: self.lastName,
                                               age: self.age,
                                               gender: self.gender,
                                               addresses: NSSet(set: self.addresses),
                                               context: context)
        
        self.addresses.forEach { $0.addEmployee(employee)}
        self.appDelegate().saveContext()
        
        completionHandler()
    }
    
    func updateEmployee(_ employee: Employee, completionHandler: @escaping (() -> Void)) {
        
        employee.update(firstName: self.firstName, lastName: self.lastName, age: self.age, gender: self.gender, addresses: NSSet(set: self.addresses))
        self.appDelegate().saveContext()
        
        completionHandler()
    }
}

extension EmployeeFormViewModel: AddressFormViewModelDelegate {
    
    func addAddress(_ address: Address) {
        self.addresses.insert(address)
    }
}
