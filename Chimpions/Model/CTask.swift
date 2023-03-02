//
//  CTask.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 01/03/23.
//

import Foundation

struct CTask: Codable, Identifiable {
    var id = UUID()
    var projectId: UUID
    var duration: TimeInterval
    var elapsedTime: TimeInterval = 0
    var project: CProject? {
        try? PersistencyManager.shared.load(projectId: projectId)
    }
    var name : String? {
        project?.name
    }
}
