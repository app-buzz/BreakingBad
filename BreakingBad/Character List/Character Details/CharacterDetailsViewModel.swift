//
//  CharacterDetailsViewModel.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

enum DetailField {
    case text(String,String)
    case image(URL)
}

class CharacterDetailsViewModel {
    
    var fields: [DetailField] = []
    
    let title: String
    
    init(character: BreakingBadCharacter) {
        self.title = character.name
        self.fields.append(.image(character.imageUrl))
        self.fields.append(.text("Occupation", character.occupation.map { String($0) }.joined(separator: ", ")))
        self.fields.append(.text("Status", character.status))
        self.fields.append(.text("Nickname", character.nickname))
        self.fields.append(.text("Season Appearance", character.appearance.map { String("Season \($0)") }.joined(separator: ", ")))
    }
    
    var numFields: Int {
        return fields.count
    }
    
    func field(at index: Int) -> DetailField? {
        guard index > -1 && index < numFields else { return nil }
        return fields[index]
    }
    
}
