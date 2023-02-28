//
//  GraphicsField.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 23/02/23.
//

import Foundation

struct GraphicsField  {
    var nodes: [GraphicsNode] = []
    var connections: [GraphicsConnection] = []
    var polygons: [GraphicsPolygon] = []
    
    func connections(of node: GraphicsNode) -> [GraphicsNode] {
        var result: [GraphicsNode] = []
        for connection in connections {
            if connection.contains(asFirst: node) {
                result.append(connection.node2)
            } else if connection.contains(asSecond: node) {
                result.append(connection.node1)
            }
        }
        return result
    }
    
    mutating func add(node: GraphicsNode) {
        nodes.append(node)
        nodes.sort { $0.position < $1.position }
    }
    
    mutating func add(connectionWithNodes node1: GraphicsNode, and node2: GraphicsNode) {
        connections.append(GraphicsConnection(node1: node1, node2: node2))
    }
    
    mutating func add(polygonWithNodes nodes: [GraphicsNode]) {
        polygons.append(GraphicsPolygon(vertices: nodes))
    }
    
    mutating func updatePolygons() {
        guard !nodes.isEmpty else { return }
        var nodes = nodes
        var lastConnection = nodes.first!
        for node in nodes {
            var connections = connections(of: node)
            connections.sort { smaller, greater in
                let smallerAngle = smaller.position - node.position
                return false
            }
        }
    }
}
