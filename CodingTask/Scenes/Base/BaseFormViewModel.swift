//
//  BaseViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class BaseFormViewModel: BaseViewModel {
    
    private var entryMode: EntryMode!
    
    func setEntryMode(_ entryMode: EntryMode, completionHandler: @escaping (() -> Void)) {
        
        self.entryMode = entryMode
        completionHandler()
    }
    
    func setEntryMode(_ entryMode: EntryMode) {
        
        self.entryMode = entryMode
    }
}
