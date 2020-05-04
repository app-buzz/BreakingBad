//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import XCTest
import Moya
@testable import Breaking_Bad

class CharacterListViewModelTests: XCTestCase {
    
    
    var viewModel:CharacterListViewModel!
    
    var stubbedItems: [BreakingBadCharacter]!
    
    override func setUp() {
        super.setUp()
        do {
            stubbedItems = try JSONDecoder().decode([BreakingBadCharacter].self, from: BreakingBadService.getCharacters.sampleData)
        } catch {
            XCTFail("Failed to stub items")
        }
        InjectionMap.breakingBadService = MoyaProvider<BreakingBadService>(stubClosure: MoyaProvider.delayedStub(1))
        viewModel = CharacterListViewModel()
    }
    
    func test_loadingProgress_isStarted() {
        XCTAssertEqual(viewModel.loadingProgress, LoadingProgress.started)
    }
    
    func test_filteredSeasons_isPopulated() {
        XCTAssertEqual(viewModel.filteredSeasons, Array(0..<FiltersViewModel.numSeasons))
    }
    
    func test_numCharacters_isZero() {
        XCTAssertEqual(viewModel.numCharacters,0)
    }
    
    func test_filtersTapped_calls_onTapFilters() {
        let expectation = XCTestExpectation(description: "Call onTapFilters")
        viewModel.onTapFilters.subscribe(with: self) { filteredSeasons in
            if filteredSeasons == Array(0..<FiltersViewModel.numSeasons) {
                expectation.fulfill()
            } else {
                XCTFail("Filered seasons doesnt contain all seasons")
            }
        }
        viewModel.filtersTapped()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_numCharacters_isTwo() {
        let expectation = XCTestExpectation(description: "")
        viewModel.onCharactersUpdated.subscribe(with: self) { empty in
            XCTAssertEqual(empty,false)
            XCTAssertEqual(self.viewModel.numCharacters,2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_characterAtZero_isFirstStubbedItem() {
        let expectation = XCTestExpectation(description: "")
        viewModel.onCharactersUpdated.subscribe(with: self) { empty in
            XCTAssertEqual(empty,false)
            guard let characterViewModel = self.viewModel.character(at: 0) else {
                XCTFail("Failed to get character at zero")
                return
            }
            XCTAssertEqual(characterViewModel.character,self.stubbedItems[0])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_didSelectItem_calls_onTapCharacter() {
        let expectation = XCTestExpectation(description: "onTapCharacter called")
        viewModel.onTapCharacter.subscribe(with: self) { character in
            XCTAssertEqual(character, self.stubbedItems[0])
            expectation.fulfill()
        }
        viewModel.onCharactersLoading.subscribe(with: self) { progress in
            switch progress {
            case .finished:
                self.viewModel.didSelectItem(at: 0)
            case .started:
                break;
            case .failed(_):
                XCTFail("Shouldn't fail loading a stub")
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_onCharactersLoading_loadingProgress_isFinished() {
        let expectation = XCTestExpectation(description: "Progress is finished")
        viewModel.onCharactersLoading.subscribe(with: self) { progress in
            switch progress {
            case .finished:
                expectation.fulfill()
            case .started:
                break;
            case .failed(_):
                XCTFail("Shouldn't failed loading a stub")
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_filteredSeasons_callsOnCharactersUpdated() {
        let expectation = XCTestExpectation(description: "Call onCharactersUpdated")
        viewModel.onCharactersUpdated.subscribe(with: self) { empty in
            XCTAssertTrue(empty)
            expectation.fulfill()
        }
        viewModel.filteredSeasons = [0]
        wait(for: [expectation], timeout: 5)
    }
    
    func test_searchText_callsOnCharactersUpdated() {
        let expectation = XCTestExpectation(description: "Call onCharactersUpdated")
        viewModel.onCharactersUpdated.subscribe(with: self) { empty in
            XCTAssertTrue(empty)
            expectation.fulfill()
        }
        viewModel.searchText = ""
        wait(for: [expectation], timeout: 5)
    }
    
    func test_noneExistantSearchText_callsOnCharactersEmpty() {
        let expectation = XCTestExpectation(description: "Call onCharactersEmpty")
        viewModel.onCharactersEmpty.subscribe(with: self) { message in
            XCTAssertEqual(message, "No characters found")
            expectation.fulfill()
        }
        viewModel.onCharactersLoading.subscribe(with: self) { progress in
            switch progress {
            case .finished:
                self.viewModel.searchText = "sfjhhjdf"
            default:
                break;
            }
        }
        wait(for: [expectation], timeout: 5)
    }

}
