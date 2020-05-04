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
            return Data()
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
