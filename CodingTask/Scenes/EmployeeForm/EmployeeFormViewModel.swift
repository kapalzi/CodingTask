//
//  EmployeeFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

protocol EmployeeFormViewModelDelegate {
    func addAddress()
}

class EmployeeFormViewModel: BaseFormViewModel {
    
    private var employee: Employee?
    var firstName: String = ""
    var lastName: String = ""
    var age: Int16 = 0
    var gender: Int16 = 0
    var addresses: NSSet = NSSet()
    
    func setEmployee(_ employee: Employee) {
        
    }
    
    func getAddressesCount() -> Int {
        return self.addresses.count
    }
}
