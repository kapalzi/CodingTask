//
//  Gender.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

//from ISO/IEC 5218
import Foundation

enum Gender: Int {

    case notKnown = 0
    case male = 1
    case female = 2
    case notApplicable = 9

    var description: String {
        switch self {
        case .notKnown:
            return "not known"
        case .male:
            return "male"
        case .female:
            return "female"
        case .notApplicable:
            return "not applicable"
        }
    }
}
