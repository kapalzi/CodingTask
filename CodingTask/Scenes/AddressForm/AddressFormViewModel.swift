//
//  AddressFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

protocol AddressFormViewModelDelegate: AnyObject {
    func addAddress(_ address: Address)
}

class AddressFormViewModel: BaseViewModel {
    
    var address: Address?
    var country: String = ""
    var locality: String = ""
    var street: String = ""
    var houseNumber: String = ""
    var flatNumber: String = ""
    var postcode: String = ""
    weak var delegate: AddressFormViewModelDelegate?
    
    func setValuesFromAddress(_ address: Address) {
        
        self.address = address
        self.country = address.country ?? ""
        self.locality = address.locality ?? ""
        self.street = address.street ?? ""
        self.houseNumber = address.houseNumber ?? ""
        self.flatNumber = address.flatNumber ?? ""
        self.postcode = address.postcode ?? ""
    }
    
    func save(completionHandler: @escaping (() -> Void)) {
        
        if let address = self.address {
            self.updateAddress(address, completionHandler: completionHandler)
        } else {
            self.saveNew(completionHandler: completionHandler)
        }
    }
    
    func saveNew(completionHandler: @escaping (() -> Void)) {
        
        let context = self.appDelegate().persistentContainer.viewContext
        let address = Address.createAddress(country: self.country,
                                            locality: self.country,
                                            street: self.street,
                                            houseNumber: self.houseNumber,
                                            flatNumber: self.flatNumber,
                                            postcode: self.postcode,
                                            inContext: context)
        self.delegate?.addAddress(address)
        completionHandler()
    }
    
    func updateAddress(_ address: Address, completionHandler: @escaping (() -> Void)) {
        
        address.update(country: self.country,
                       locality: self.locality,
                       street: self.street,
                       houseNumber: self.houseNumber,
                       flatNumber: self.flatNumber,
                       postcode: self.postcode)
        self.appDelegate().saveContext()
        
        completionHandler()
    }
}
