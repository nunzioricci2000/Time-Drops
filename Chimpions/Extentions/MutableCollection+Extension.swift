//
//  MutableCollection+Extension.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import Foundation

extension MutableCollection {
    mutating func modifyEach(_ modify: (inout Element) throws -> Void) rethrows {
        var i = startIndex
        while i != endIndex {
            try modify(&self[i])
            formIndex(after: &i)
        }
    }
}
