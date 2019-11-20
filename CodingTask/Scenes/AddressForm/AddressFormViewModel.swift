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

class AddressFormViewModel: BaseFormViewModel {
    
    private var address: Address?
    var country: String = ""
    var locality: String = ""
    var street: String = ""
    var houseNumber: String = ""
    var flatNumber: String = ""
    var postcode: String = ""
    weak var delegate: AddressFormViewModelDelegate?
    
    func save(completionHandler: @escaping (() -> Void)) {
        
        let context = self.appDelegate().persistentContainer.viewContext
        let address = Address.createAddress(country: self.country,
                                            locality: self.country,
                                            street: self.street,
                                            houseNumber: self.houseNumber,
                                            flatNumber: self.flatNumber,
                                            postcode: self.postcode,
                                            inContext: context)
        
        self.appDelegate().saveContext()
        self.delegate?.addAddress(address)
        completionHandler()
    }
}
