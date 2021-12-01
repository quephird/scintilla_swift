//
//  ShapeTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/30/21.
//

import XCTest

class ShapeTests: XCTestCase {
    func testWorldToObjectForNestedObject() throws {
        let g1 = Group(rotationY(PI/2), DEFAULT_MATERIAL)
        let g2 = Group(scaling(2, 2, 2), DEFAULT_MATERIAL)
        g1.addChild(g2)
        let s = Sphere(translation(5, 0, 0), DEFAULT_MATERIAL)
        g2.addChild(s)

        let actualValue = s.worldToObject(point(-2, 0, -10))
        let expectedValue = point(0, 0, -1)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testObjectToWorldForNestedObject() throws {
        let g1 = Group(rotationY(PI/2), DEFAULT_MATERIAL)
        let g2 = Group(scaling(1, 2, 3), DEFAULT_MATERIAL)
        g1.addChild(g2)
        let s = Sphere(translation(5, 0, 0), DEFAULT_MATERIAL)
        g2.addChild(s)

        let actualValue = s.objectToWorld(vector(sqrt(3)/3, sqrt(3)/3, sqrt(3)/3))
        let expectedValue = vector(0.28571, 0.42857, -0.85714)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testNormalForNestedObject() throws {
        let g1 = Group(rotationY(PI/2), DEFAULT_MATERIAL)
        let g2 = Group(scaling(1, 2, 3), DEFAULT_MATERIAL)
        g1.addChild(g2)
        let s = Sphere(translation(5, 0, 0), DEFAULT_MATERIAL)
        g2.addChild(s)

        let actualValue = s.normal(point(1.7321, 1.1547, -5.5774))
        let expectedValue = vector(0.28570, 0.42854, -0.85716)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }
}
