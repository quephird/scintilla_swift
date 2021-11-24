//
//  WorldTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/23/21.
//

import XCTest

class WorldTests: XCTestCase {
    func testIntersect() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let intersections = world.intersect(ray)
        XCTAssertEqual(intersections.count, 4)
        XCTAssert(intersections[0].t.isAlmostEqual(4))
        XCTAssert(intersections[1].t.isAlmostEqual(4.5))
        XCTAssert(intersections[2].t.isAlmostEqual(5.5))
        XCTAssert(intersections[3].t.isAlmostEqual(6))
    }
}
