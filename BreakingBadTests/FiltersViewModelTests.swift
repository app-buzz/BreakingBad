//
//  FiltersViewModelTests.swift
//  BreakingBadTests
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import XCTest
@testable import Breaking_Bad

class FiltersViewModelTests: XCTestCase {
    
    private var viewModel: FiltersViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FiltersViewModel(selectedSeasons: [])
    }
    
    func test_numSeasons_is5() {
        XCTAssertEqual(FiltersViewModel.numSeasons,5)
    }
    
    func test_filter_invalidIndex_returnsNil() {
        let invalidFilter = viewModel.filter(at: 6)
        XCTAssertNil(invalidFilter)
    }
    
    func test_filter_negativeInvalidIndex_returnsNil() {
        let invalidFilter = viewModel.filter(at: -1)
        XCTAssertNil(invalidFilter)
    }
    
    func test_filter_validIndex_returnsCorrectFilterViewModel() {
        let validFilter = viewModel.filter(at: 0)
        XCTAssertEqual(validFilter?.labelText,"Season 1")
    }
    
    func test_numFilters_isSameAs_numSeasons() {
        XCTAssertEqual(viewModel.numFilters, FiltersViewModel.numSeasons)
    }
    
    func test_tappedCancel_calls_onTapCancel() {
        let expectation = XCTestExpectation(description: "Call onTapCancel")
        viewModel.onTapCancel.subscribe(with: self) {
            expectation.fulfill()
        }
        viewModel.tappedCancel()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_tappedApply_calls_onTapApply() {
        let seasons = [0,1,2]
        viewModel.selectedSeasons = seasons
        let expectation = XCTestExpectation(description: "Call onTapApply")
        viewModel.onTapApply.subscribe(with: self) { selectedSeasons in
            if selectedSeasons == seasons {
                expectation.fulfill()
            } else {
                XCTFail("Selected seasons dont match")
            }
        }
        viewModel.tappedApply()
        wait(for: [expectation], timeout: 1)
    }

}
