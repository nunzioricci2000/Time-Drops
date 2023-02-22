//
//  PhysicsWorld.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import Foundation

struct PhysicsWorld {
    var bodies: [PhysicsBody] = []
    var joints: [PhysicsJoint] = []
    private var lastUpdate = Date()
    private let gravity = CGVector(dx: 0, dy: 0)
    
    mutating func add(body: PhysicsBody) {
        bodies.append(body)
    }
    
    mutating func add(joint: PhysicsJoint) {
        joints.append(joint)
    }
    
    func getBody(by id: UUID) -> PhysicsBody? {
        for body in bodies {
            if body.id == id {
                return body
            }
        }
        return nil
    }
    
    mutating func set(body: PhysicsBody) {
        guard let index = bodies.firstIndex(where: { $0.id == body.id }) else { return }
        bodies[index] = body
    }
    
    mutating func remove(body: PhysicsBody) {
        guard let index = bodies.firstIndex(where: { $0.id == body.id }) else { return }
        bodies.remove(at: index)
        var i = joints.startIndex
        while i < joints.endIndex {
            let body1 = joints[i].body1
            let body2 = joints[i].body2
            if body1.id == body.id || body2.id == body.id {
                joints.remove(at: i)
            }
            i = joints.index(after: i)
        }
    }
    
    mutating func update() {
        let now = Date()
        let deltaTime = now.timeIntervalSince(lastUpdate)
        lastUpdate = now
        var this = self
        joints.modifyEach { joint in
            guard let body1 = this.getBody(by: joint.body1.id) else { return }
            guard let body2 = this.getBody(by: joint.body2.id) else { return }
            joint.body1 = body1
            joint.body2 = body2
            joint.update()
            this.set(body: joint.body1)
            this.set(body: joint.body2)
        }
        self = this
        let gravity = gravity
        bodies.modifyEach { body in
            body.apply(force: gravity)
            body.update(deltaTime: deltaTime)
        }
    }
}
