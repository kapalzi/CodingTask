//
//  EntryMode.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

enum EntryMode:Int {
    case create = 0
    case edit = 1
    
    public func isEditMode() -> Bool
    {
        return self == .edit
    }
}
