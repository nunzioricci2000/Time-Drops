//
//  PhysicsView.swift
//  Chimpions
//
//  Created by Nunzio Ricci on 21/02/23.
//

import SwiftUI

struct PhysicsObject: View {
    @State private var isUpdating = false
    @State private var physicsWorld = PhysicsWorld()
    @State private var timer: Timer?
    @State private var tapBody: PhysicsBody?
    
    var body: some View {
        ZStack {
            Color.pink
            ForEach(physicsWorld.bodies) { body in
                Circle().frame(width: 20)
                    .position(x: body.position.x,
                            y: body.position.y)
            }
        }.gesture(DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                if tapBody == nil {
                    tapBody = PhysicsBody()
                    for body in physicsWorld.bodies {
                        var joint = PhysicsJoint(body1: tapBody!, body2: body)
                        joint.normalLength = 0
                        physicsWorld.add(joint: joint)
                    }
                    tapBody!.isDynamic = false
                    physicsWorld.add(body: tapBody!)
                }
                tapBody!.position = gesture.location
                physicsWorld.set(body: tapBody!)
            }.onEnded { _ in
                physicsWorld.remove(body: tapBody!)
                tapBody = nil
            })
        .onAppear {
            let body1 = PhysicsBody()
            var body2 = PhysicsBody()
            var body3 = PhysicsBody()
            var body4 = PhysicsBody()
            let joint1 = PhysicsJoint(body1: body1, body2: body2)
            let joint2 = PhysicsJoint(body1: body2, body2: body3)
            let joint3 = PhysicsJoint(body1: body3, body2: body1)
            let joint4 = PhysicsJoint(body1: body4, body2: body1)
            let joint5 = PhysicsJoint(body1: body4, body2: body2)
            let joint6 = PhysicsJoint(body1: body4, body2: body3)
            body2.position = .init(x: 50, y: 0)
            body3.position = .init(x: 0, y: 50)
            body4.position = .init(x: 50, y: 50)
            physicsWorld.add(body: body1)
            physicsWorld.add(body: body2)
            physicsWorld.add(body: body3)
            physicsWorld.add(body: body4)
            physicsWorld.add(joint: joint1)
            physicsWorld.add(joint: joint2)
            physicsWorld.add(joint: joint3)
            physicsWorld.add(joint: joint4)
            physicsWorld.add(joint: joint5)
            physicsWorld.add(joint: joint6)
            timer = .scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                update()
            }
        }
    }
    
    func update() {
        guard !isUpdating else { return }
        isUpdating = true
        physicsWorld.update()
        isUpdating = false
    }
}

struct PhysicsView: View {
    var body: some View {
        PhysicsObject()
    }
}

struct PhysicsView_Previews: PreviewProvider {
    static var previews: some View {
        PhysicsView()
    }
}
