//
//  FiltersViewModel.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import Signals

class FiltersViewModel {
    
    static let numSeasons: Int = 5
    
    var selectedSeasons: [Int]
    
    var filters:[FilterViewModel] = []
    
    let onTapApply = Signal<[Int]>()
    let onTapCancel = Signal<Void>()
    
    init(selectedSeasons: [Int]) {
        self.selectedSeasons = selectedSeasons
        for s in 0..<FiltersViewModel.numSeasons {
            let filter = FilterViewModel(season: s+1)
            filters.append(filter)
        }
    }
    
    func tappedCancel() {
        onTapCancel.fire()
    }
    
    func tappedApply() {
        onTapApply.fire(selectedSeasons)
    }
    
    var numFilters: Int {
        return filters.count
    }
    
    func filter(at index:Int) -> FilterViewModel? {
        guard index > -1 && index < FiltersViewModel.numSeasons else { return nil }
        return filters[index]
    }
    
}
