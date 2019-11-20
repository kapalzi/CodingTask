//
//  AddressFormViewModel.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class AddressFormViewModel: BaseFormViewModel {
    
    private var address: Address?
    var country: String = ""
    var locality: String = ""
    var street: String = ""
    var houseNumber: String = ""
    var flatNumber: String = ""
    var postcode: String = ""
    
    func save(completionHandler: @escaping (() -> Void)) {
        
        let context = self.appDelegate().persistentContainer.viewContext
        Address.createAddress(country: self.country,
                                            locality: self.country,
                                            street: self.street,
                                            houseNumber: self.houseNumber,
                                            flatNumber: self.flatNumber,
                                            postcode: self.postcode,
                                            inContext: context)
        
        self.appDelegate().saveContext()
        completionHandler()
    }
}
