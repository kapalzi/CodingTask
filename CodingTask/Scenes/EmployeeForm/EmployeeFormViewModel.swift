//
//  EmployeeFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class EmployeeFormViewModel {
    
    private var entryMode: EntryMode!
    private var employee: Employee?
    
    func setEntryMode(_ entryMode: EntryMode, completionHandler: @escaping (() -> Void)) {
        
        self.entryMode = entryMode
        completionHandler()
    }
    
    func setEntryMode(_ entryMode: EntryMode) {
        
        self.entryMode = entryMode
    }
    
    func setEmployee(_ employee: Employee) {
        
    }
}
