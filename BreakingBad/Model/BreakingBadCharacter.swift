//
//  BreakingBadCharacter.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

struct BreakingBadCharacter: Decodable {
    
    var id: Int
    var name: String
    var nickname: String
    var occupation: [String]
    var imageUrl: URL
    var status: String
    var appearance: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case imageUrl = "img"
        case name, nickname, occupation, status, appearance
    }
}
