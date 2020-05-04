//
//  ReusableCell.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

protocol ReusableCell {}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
