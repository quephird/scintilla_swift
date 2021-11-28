//
//  CylinderTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/27/21.
//

import XCTest

class CylinderTests: XCTestCase {
    func testLocalIntersectMisses() throws {
        let cylinder = Cylinder(IDENTITY4, DEFAULT_MATERIAL)

        let testCases = [
            (point(1, 0, 0), vector(0, 1, 0)),
            (point(0, 0, 0), vector(0, 1, 0)),
            (point(0, 0, -5), vector(1, 1, 1)),
        ]

        for (origin, direction) in testCases {
            let ray = Ray(origin, direction)
            let allIntersections = cylinder.localIntersect(ray)
            XCTAssertEqual(allIntersections.count, 0)
        }
    }
}
