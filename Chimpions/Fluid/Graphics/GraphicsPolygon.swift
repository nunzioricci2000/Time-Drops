//
//  GraphicsPolygon.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 23/02/23.
//

import Foundation

struct GraphicsPolygon {
    var vertices: [GraphicsNode]
    
    func contains(_ node: GraphicsNode) -> Bool {
        guard !vertices.isEmpty else { return false }
        var totalAngle = 0.0
        var previousVertex = vertices.last!
        for vertex in vertices {
            let vector1 = previousVertex.position - node.position
            let vector2 = vertex.position - node.position
            let angle = vector1 ^ vector2
            totalAngle += angle
            totalAngle += angle > .pi ? -.pi : 0
            previousVertex = vertex
        }
        return totalAngle > 0
    }
}
