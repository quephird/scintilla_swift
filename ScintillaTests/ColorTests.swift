//
//  ColorTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/19/21.
//

import XCTest

class ColorTests: XCTestCase {
    func testAdd() throws {
        let c1 = Color(r: 0.9, g: 0.6, b: 0.75)
        let c2 = Color(r: 0.7, g: 0.1, b: 0.25)
        XCTAssert(c1.add(c2).isAlmostEqual(Color(r: 1.6, g: 0.7, b: 1.0)))
    }

    func testSubtract() throws {
        let c1 = Color(r: 0.9, g: 0.6, b: 0.75)
        let c2 = Color(r: 0.7, g: 0.1, b: 0.25)
        let actualValue = c1.subtract(c2)
        let expectedValue = Color(r: 0.2, g: 0.5, b: 0.5)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testMultipleScalar() throws {
        let c = Color(r: 0.2, g: 0.3, b: 0.4)
        XCTAssert(c.multiply_scalar(2).isAlmostEqual(Color(r: 0.4, g: 0.6, b: 0.8)))
    }

    func testHadamard() throws {
        let c1 = Color(r: 1.0, g: 0.2, b: 0.4)
        let c2 = Color(r: 0.9, g: 1.0, b: 0.1)
        let expectedValue = Color(r: 0.9, g: 0.2, b: 0.04)
        XCTAssert(c1.hadamard(c2).isAlmostEqual(expectedValue))
    }
}
