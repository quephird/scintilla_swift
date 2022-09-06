//
//  ShapeTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/30/21.
//

import XCTest

class ShapeTests: XCTestCase {
    func testWorldToObjectForNestedObject() throws {
        let g1 = Group(.defaultMaterial)
            .rotateY(PI/2)
        let g2 = Group(.defaultMaterial)
            .scale(2, 2, 2)
        g1.addChild(g2)
        let s = Sphere(.defaultMaterial)
            .translate(5, 0, 0)
        g2.addChild(s)

        let actualValue = s.worldToObject(point(-2, 0, -10))
        let expectedValue = point(0, 0, -1)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testObjectToWorldForNestedObject() throws {
        let g1 = Group(.defaultMaterial)
            .rotateY(PI/2)
        let g2 = Group(.defaultMaterial)
            .scale(1, 2, 3)
        g1.addChild(g2)
        let s = Sphere(.defaultMaterial)
            .translate(5, 0, 0)
        g2.addChild(s)

        let actualValue = s.objectToWorld(vector(sqrt(3)/3, sqrt(3)/3, sqrt(3)/3))
        let expectedValue = vector(0.28571, 0.42857, -0.85714)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testNormalForNestedObject() throws {
        let g1 = Group(.defaultMaterial)
            .rotateY(PI/2)
        let g2 = Group(.defaultMaterial)
            .scale(1, 2, 3)
        g1.addChild(g2)
        let s = Sphere(.defaultMaterial)
            .translate(5, 0, 0)
        g2.addChild(s)

        let actualValue = s.normal(point(1.7321, 1.1547, -5.5774))
        let expectedValue = vector(0.28570, 0.42854, -0.85716)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }
}
