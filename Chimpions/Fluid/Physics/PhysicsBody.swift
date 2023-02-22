//
//  PhysicsBody.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import Foundation

struct PhysicsBody: Identifiable {
    var position: CGPoint = .zero
    var velocity: CGVector = .zero
    var isDynamic: Bool = true {
        didSet {
            velocity = .zero
        }
    }
    var mass: CGFloat = 1
    var friction: CGFloat = 20
    private var forces: [CGVector] = []
    
    let id = UUID()
    
    mutating func apply(force: CGVector) {
        forces.append(force)
    }
    
    private func acceleration(for force: CGVector) -> CGVector {
        return (1 / mass) * force
    }
    
    mutating func update(deltaTime: TimeInterval) {
        guard isDynamic else { return }
        for force in forces {
            velocity += deltaTime * acceleration(for: force)
        }
        velocity += deltaTime * acceleration(for: -friction * velocity)
        position += deltaTime * velocity
        forces = []
    }
}
