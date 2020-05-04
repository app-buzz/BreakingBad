//
//  FilterViewModel.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

struct FilterViewModel {
    
    let labelText: String
    let season: Int
    
    init(season: Int) {
        self.season = season
        self.labelText = "Season \(season)"
    }
    
}
