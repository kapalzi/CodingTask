//
//  EmployeeFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class EmployeeFormViewModel: BaseFormViewModel {
    
    private var employee: Employee?
    var firstName: String = ""
    var lastName: String = ""
    var age: Int16 = 0
    var gender: Int16 = 0
    var addresses: Set = Set<Address>()
    
    func setEmployee(_ employee: Employee) {
        
    }
    
    func getAddressesCount() -> Int {
        return self.addresses.count
    }
    
    func save(completionHandler: @escaping (() -> Void)) {
        
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
}

extension EmployeeFormViewModel: AddressFormViewModelDelegate {
    
    func addAddress(_ address: Address) {
        self.addresses.insert(address)
    }
}
