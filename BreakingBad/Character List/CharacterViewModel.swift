//
//  CharacterViewModel.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    
    let character: BreakingBadCharacter
    let name: String
    let imageUrl: URL
    
    init(character:BreakingBadCharacter) {
        self.character = character
        self.name = character.name
        self.imageUrl = character.imageUrl
    }
}
