//
//  CGPoint+Operations.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import CoreGraphics

extension CGVector {
    var module: CGFloat { sqrt(self * self) }
    
    var versor: CGVector { (1 / module) * self }
    
    var angle: CGFloat {
        if dx == 0 {
            if dy == 0 {
                return 0
            } else if dy > 0 {
                return.pi / 2
            } else {
                return .pi * 3 / 2
            }
        }
        var result: CGFloat = atan(dy / dx)
        if dx < 0 {
            result += .pi
        }
        if result < 0 {
            result += 2 * .pi
        }
        return result
    }
    
    static func +(first: CGVector, second: CGVector) -> CGVector {
        return CGVector(dx: first.dx + second.dx, dy: first.dy + second.dy)
    }
    
    static prefix func -(vector: CGVector) -> CGVector{
        return CGVector(dx: -vector.dx, dy: -vector.dy)
    }
    
    static func -(first: CGVector, second: CGVector) -> CGVector {
        return first + (-second)
    }
    
    static func *(first: CGVector, second: CGVector) -> CGFloat {
        return first.dx * second.dx + first.dy * second.dy
    }
    
    static func *(scalar: CGFloat, vector: CGVector) -> CGVector {
        return CGVector(dx: scalar * vector.dx, dy: scalar * vector.dy)
    }
    
    static func ^(first: CGVector, second: CGVector) -> CGFloat {
        var result =  first.angle - second.angle
        if result < 0 {
            result += 2 * .pi
        }
        return result
    }
    
    static func +=(self: inout CGVector, other: CGVector) {
        self = self + other
    }
    
    static func -=(self: inout CGVector, other: CGVector) {
        self = self - other
    }
    
    static func *=(self: inout CGVector, scalar: CGFloat) {
        self = scalar * self
    }
}

extension CGPoint {
    static func +(point: CGPoint, vector: CGVector) -> CGPoint {
        return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
    }
    
    static func -(point: CGPoint, vector: CGVector) -> CGPoint {
        return point + (-vector)
    }
    
    static func -(first: CGPoint, second: CGPoint) -> CGVector {
        return CGVector(dx: first.x - second.x, dy: first.y - second.y)
    }
    
    static func +=(self: inout CGPoint, other: CGVector) {
        self = self + other
    }
    
    static func -=(self: inout CGPoint, other: CGVector) {
        self = self - other
    }
}
