//
//  PersistencyManager.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 28/02/23.
//

import CoreData

class PersistencyManager {
    static let shared = PersistencyManager()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func key(for project: CProject) -> String {
        "project/" + project.id.uuidString
    }
    
    func id(for key: String) throws -> UUID {
        let parts = key.split(separator: "/")
        let idString = String(parts[1])
        guard let id = UUID(uuidString: idString) else {
            throw PersistencyError.invalidId(idString)
        }
        return id
    }
    
    func encode(_ project: CProject) throws -> Data {
        try encoder.encode(project)
    }
    
    func encode(_ task: CTask) throws -> Data {
        try encoder.encode(task)
    }
    
    func decode(project: Data) throws -> CProject {
        try decoder.decode(CProject.self, from: project)
    }
    
    func decode(task: Data) throws -> CTask {
        try decoder.decode(CTask.self, from: task)
    }
    
    func getAllKeys() -> [String] {
        var result: [String] = []
        let dictionary = UserDefaults.standard.dictionaryRepresentation()
        for (key, _) in dictionary {
            result.append(key)
        }
        return result
    }
    
    func getAllProjects() -> [CProject] {
        var keys = getAllKeys().filter { $0.starts(with: "project/") }
        var projectsData = keys.map( { UserDefaults.standard.data(forKey: $0) }).filter({ $0 != nil }) as! [Data]
        var projects = projectsData.map({ try? decode(project: $0) }).filter({ $0 != nil }) as! [CProject]
        return projects
    }
    
    func getAllTasks() -> [CTask] {
        var keys = getAllKeys().filter { $0.starts(with: "task/") }
        var tasksData = keys.map( { UserDefaults.standard.data(forKey: $0) }).filter({ $0 != nil }) as! [Data]
        var tasks = tasksData.map({ try? decode(task: $0) }).filter({ $0 != nil }) as! [CTask]
        return tasks
    }
    
    func save(project: CProject) throws {
        let data = try encoder.encode(project)
        let key = "project/" + project.id.uuidString
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load(projectId id: UUID) throws -> CProject {
        let key = id.uuidString
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw PersistencyError.nilData(forKey: key)
        }
        let project = try decoder.decode(CProject.self, from: data)
        return project
    }
}

enum PersistencyError: Error {
    case nilData(forKey: String)
    case invalidId(String)
}
