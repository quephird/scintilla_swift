//
//  RayTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/22/21.
//

import XCTest

class RayTests: XCTestCase {
    func testPosition() throws {
        let r = Ray(point(2, 3, 4), vector(1, 0, 0))
        XCTAssert(r.position(0).isAlmostEqual(point(2, 3, 4)))
        XCTAssert(r.position(1).isAlmostEqual(point(3, 3, 4)))
        XCTAssert(r.position(-1).isAlmostEqual(point(1, 3, 4)))
        XCTAssert(r.position(2.5).isAlmostEqual(point(4.5, 3, 4)))
    }
}
