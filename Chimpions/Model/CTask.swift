//
//  CTask.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 28/02/23.
//

import Foundation

struct CTask : Hashable, Sendable{
    var name: String
    var duration: Int
    var status: String
    var timestamp: Date
}
