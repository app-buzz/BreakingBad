//
//  FilterViewModelTests.swift
//  BreakingBadTests
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import XCTest
@testable import Breaking_Bad

class FilterViewModelTests: XCTestCase {
    
    func test_labelText_formatted_correctly() {
        let viewModel = FilterViewModel(season:1)
        XCTAssertEqual(viewModel.labelText, "Season 1")
    }

}
