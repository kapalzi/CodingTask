//
//  Address+CoreDataClass.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 18/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {

    static func createAddress(country: String, locality: String, street: String, houseNumber: String, flatNumber: String, postcode: String, inContext context: NSManagedObjectContext) -> Address {

        let newAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: context) as! Address
        newAddress.country = country
        newAddress.locality = locality
        newAddress.street = street
        newAddress.houseNumber = houseNumber
        newAddress.flatNumber = flatNumber
        newAddress.postcode = postcode

        return newAddress
    }

    func update(country: String?, locality: String?, street: String?, houseNumber: String?, flatNumber: String?, postcode: String?) {

        self.country = country ?? self.country
        self.locality = locality ?? self.locality
        self.street = street ?? self.street
        self.houseNumber = houseNumber ?? self.houseNumber
        self.flatNumber = flatNumber ?? self.flatNumber
        self.postcode = postcode ?? self.postcode
    }

    func addEmployee(_ employee: Employee) {
        self.employee = employee
    }
}
