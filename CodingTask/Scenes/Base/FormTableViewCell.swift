//
//  FormTableViewCell.swift
//  CodingTask
//
//  Created by Krzysztof Kapała on 20/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var valueTextField: UITextField!

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = .white
    }
}
