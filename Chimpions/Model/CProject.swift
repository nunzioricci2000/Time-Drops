//
//  CProject.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 01/03/23.
//

import Foundation

struct CProject: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
}
