//
//  InjectionMap.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import Moya

struct InjectionMap {
    static var breakingBadService = MoyaProvider<BreakingBadService>()
}

protocol BreakingBadServiceInjected {}

extension BreakingBadServiceInjected {
    var breakingBadService:MoyaProvider<BreakingBadService> {
        return InjectionMap.breakingBadService
    }
}
