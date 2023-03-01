//
//  CTask.swift
//  Chimpions
//
//  Created by Bruno De Vivo on 28/02/23.
//

import Foundation

struct CTask: Codable, Identifiable {
    var id = UUID()
    var projectId: UUID
    var duration: TimeInterval
}
