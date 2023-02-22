//
//  PhysicsJoint.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 22/02/23.
//

import Foundation

struct PhysicsJoint {
    var normalLength: CGFloat = 50
    let k: CGFloat = 10
    
    var body1: PhysicsBody
    var body2: PhysicsBody
    
    var vector: CGVector {
        return body1.position - body2.position
    }
    
    var length: CGFloat {
        return vector.module
    }
    
    var appliedForceModule: CGFloat {
        let deltaLength = (length - normalLength)
        return k * deltaLength * abs(deltaLength)
    }
    
    var forceOnBody1: CGVector {
        return -appliedForceModule * vector.versor
    }
    
    var forceOnBody2: CGVector {
        return appliedForceModule * vector.versor
    }
    
    init(body1: PhysicsBody, body2: PhysicsBody) {
        self.body1 = body1
        self.body2 = body2
    }
    
    mutating func update() {
        body1.apply(force: forceOnBody1)
        body2.apply(force: forceOnBody2)
    }
}
