//
//  BaseViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class BaseViewModel {

    func appDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
}
