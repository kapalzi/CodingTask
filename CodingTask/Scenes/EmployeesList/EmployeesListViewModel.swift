//
//  EmployeesListViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 19/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class EmployeesListViewModel {
    
    var employees: [Employee] = [Employee]()
    
    func getAllEmployees() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        Employee.getAllEmployees(inContext: context)
    }
    
}
