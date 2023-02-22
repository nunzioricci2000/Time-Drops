//
//  PhysicsBody.swift
//  ChimpionsTests
//
//  Created by Nunzio Ricci on 21/02/23.
//

import XCTest
@testable import Chimpions

final class PhysicsBodyTests: XCTestCase {
    var instance: PhysicsBody!
    
    override func setUpWithError() throws {
        instance = PhysicsBody()
    }
    
    func testUpdate() throws {
        instance.apply(force: .init(dx: 10, dy: 10))
        instance.update(deltaTime: 1)
        XCTAssertEqual(instance.velocity, .init(dx: 10, dy: 10))
    }
}
