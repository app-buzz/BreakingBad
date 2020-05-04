//
//  BreakingBadService.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import Moya

enum BreakingBadService {
    case getCharacters
}

extension BreakingBadService: TargetType {
    
    var path: String {
        switch self {
        case .getCharacters:
            return "characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getCharacters:
            return "[{\"char_id\":1,\"name\":\"Walter White\",\"birthday\":\"09-07-1958\",\"occupation\":[\"High School Chemistry Teacher\",\"Meth King Pin\"],\"img\":\"https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg\",\"status\":\"Presumed dead\",\"nickname\":\"Heisenberg\",\"appearance\":[1,2,3,4,5],\"portrayed\":\"Bryan Cranston\",\"category\":\"Breaking Bad\",\"better_call_saul_appearance\":[]},{\"char_id\":2,\"name\":\"Jesse Pinkman\",\"birthday\":\"09-24-1984\",\"occupation\":[\"Meth Dealer\"],\"img\":\"https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Jesse_Pinkman2.jpg/220px-Jesse_Pinkman2.jpg\",\"status\":\"Alive\",\"nickname\":\"Cap n' Cook\",\"appearance\":[1,2],\"portrayed\":\"Aaron Paul\",\"category\":\"Breaking Bad\",\"better_call_saul_appearance\":[]}]".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .getCharacters:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    var baseURL: URL { return URL(string: "https://breakingbadapi.com/api/")! }
}
