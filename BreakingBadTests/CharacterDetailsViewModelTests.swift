//
//  CharacterDetailsViewModelTests.swift
//  BreakingBadTests
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import XCTest
@testable import Breaking_Bad

class CharacterDetailsViewModelTests: XCTestCase {
    
    var viewModel: CharacterDetailsViewModel!
    var stub: BreakingBadCharacter!

    override func setUp() {
        super.setUp()
        if let stubs = try? JSONDecoder().decode([BreakingBadCharacter].self, from: BreakingBadService.getCharacters.sampleData) {
            stub = stubs[0]
            viewModel = CharacterDetailsViewModel(character: stub)
        } else {
            XCTFail("Failed to parse stubs")
        }
    }
    
    func test_title_isStubsName() {
        XCTAssertEqual(viewModel.title,stub.name)
    }
    
    func test_numFields_isFive() {
        XCTAssertEqual(viewModel.numFields,5)
    }
    
    func test_firstField_isImage() {
        guard let field = viewModel.field(at: 0) else {
            XCTFail("Field is nil")
            return
        }
        XCTAssertEqual(field, DetailField.image(stub.imageUrl))
    }
    
    func test_secondField_isOccupation() {
        guard let field = viewModel.field(at: 1) else {
            XCTFail("Field is nil")
            return
        }
        XCTAssertEqual(field, DetailField.text("Occupation",stub.occupation.joined(separator: ", ")))
    }
    
    func test_thirdField_isStatus() {
        guard let field = viewModel.field(at: 2) else {
            XCTFail("Field is nil")
            return
        }
        XCTAssertEqual(field, DetailField.text("Status",stub.status))
    }
    
    func test_fourthField_isNickname() {
        guard let field = viewModel.field(at: 3) else {
            XCTFail("Field is nil")
            return
        }
        XCTAssertEqual(field, DetailField.text("Nickname",stub.nickname))
    }
    
    func test_fifthField_isSeasonAppearance() {
        guard let field = viewModel.field(at: 4) else {
            XCTFail("Field is nil")
            return
        }
        XCTAssertEqual(field, DetailField.text("Season Appearance",stub.appearance.map { String("Season \($0)") }.joined(separator: ", ")))
    }

}
