//
//  FilterCell.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setup(viewModel: FilterViewModel) {
        self.seasonLabel.text = viewModel.labelText
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = (selected) ? .checkmark : .none
    }
    
}
