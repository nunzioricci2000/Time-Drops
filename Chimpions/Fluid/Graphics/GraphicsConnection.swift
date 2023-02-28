//
//  GraphicsConnection.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 22/02/23.
//

import Foundation

struct GraphicsConnection {
    var node1, node2: GraphicsNode
    
    var vectorized: CGVector {
        return node2.position - node1.position
    }
    
    func contains(asFirst node: GraphicsNode) -> Bool {
        if node.id == node1.id { return true }
        return false
    }
    
    func contains(asSecond node: GraphicsNode) -> Bool {
        if node.id == node1.id { return true }
        return false
    }
    
    func contains(_ node: GraphicsNode) -> Bool {
        return contains(asFirst: node) || contains(asSecond: node)
    }
}
