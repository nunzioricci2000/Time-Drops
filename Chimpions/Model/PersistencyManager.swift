//
//  PersistencyManager.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 28/02/23.
//

import CoreData

class PersistencyManager: ObservableObject {
    static let shared = PersistencyManager()
    static let preview = {
        let manager = shared
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        let project = CProject(name: "Presentation")
        try! manager.save(project: project)
        try! manager.save(project: CProject(name: "Cooking meth"))
        try! manager.save(project: CProject(name: "Grabbing coke"))
        try! manager.save(project: CProject(name: "Other horrible things"))
        try! manager.save(task: CTask(projectId: project.id, duration: 7200))
        return manager
    }()
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
        let keys = getAllKeys().filter { $0.starts(with: "project/") }
        let projectsData = keys.map( { UserDefaults.standard.data(forKey: $0) }).filter({ $0 != nil }) as! [Data]
        let projects = projectsData.map({ try? decode(project: $0) }).filter({ $0 != nil }) as! [CProject]
        return projects
    }
    
    func getAllTasks() -> [CTask] {
        let keys = getAllKeys()
            .filter { $0.starts(with: "task/") }
        let tasksData = keys
            .map( { UserDefaults.standard.data(forKey: $0) })
            .filter({ $0 != nil }) as! [Data]
        let tasks = tasksData
            .map({ try? decode(task: $0) })
            .filter({ $0 != nil }) as! [CTask]
        return tasks
    }
    
    func save(project: CProject) throws {
        let data = try encoder.encode(project)
        let key = "project/" + project.id.uuidString
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func save(task: CTask) throws {
        let data = try encoder.encode(task)
        let key = "task/" + task.id.uuidString
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load(projectId id: UUID) throws -> CProject {
        let key = "project/" + id.uuidString
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw PersistencyError.nilData(forKey: key)
        }
        let project = try decoder.decode(CProject.self, from: data)
        return project
    }
    
    func load(taskId id: UUID) throws -> CTask {
        let key = "task/" + id.uuidString
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw PersistencyError.nilData(forKey: key)
        }
        let task = try decoder.decode(CTask.self, from: data)
        return task
    }
}

enum PersistencyError: Error {
    case nilData(forKey: String)
    case invalidId(String)
}
