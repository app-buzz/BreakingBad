//
//  CharacterDetailTextCell.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailTextCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var fieldLabel: UILabel!
    
    func setup(field: DetailField) {
        guard case let DetailField.text(fieldName,fieldValue) = field else { return }
        fieldLabel.text = fieldName+": "+fieldValue
    }
    
}
