//
//  PatternTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/24/21.
//

import XCTest

class PatternTests: XCTestCase {
    func testStripePatternIsConstantInY() throws {
        let pattern = Striped(WHITE, BLACK, IDENTITY4)
        XCTAssertTrue(pattern.colorAt(point(0, 0, 0)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(0, 1, 0)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(0, 2, 0)).isAlmostEqual(WHITE))
    }

    func testStripePatternIsConstantInZ() throws {
        let pattern = Striped(WHITE, BLACK, IDENTITY4)
        XCTAssertTrue(pattern.colorAt(point(0, 0, 0)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(0, 0, 1)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(0, 0, 2)).isAlmostEqual(WHITE))
    }

    func testStripePatternAlternatestInX() throws {
        let pattern = Striped(WHITE, BLACK, IDENTITY4)
        XCTAssertTrue(pattern.colorAt(point(0, 0, 0)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(0.9, 0, 0)).isAlmostEqual(WHITE))
        XCTAssertTrue(pattern.colorAt(point(1, 0, 0)).isAlmostEqual(BLACK))
        XCTAssertTrue(pattern.colorAt(point(-0.1, 0, 0)).isAlmostEqual(BLACK))
        XCTAssertTrue(pattern.colorAt(point(-1, 0, 0)).isAlmostEqual(BLACK))
        XCTAssertTrue(pattern.colorAt(point(-1.1, 0, 0)).isAlmostEqual(WHITE))
    }

    func testStripePatternWithObjectTransformation() throws {
        let shape = Sphere(scaling(2, 2, 2), DEFAULT_MATERIAL)
        let pattern = Striped(WHITE, BLACK, IDENTITY4)
        let actualValue = pattern.colorAt(shape, point(1.5, 0, 0))
        let expectedValue = WHITE
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testStripePatternWithPatternTransformation() throws {
        let shape = Sphere(IDENTITY4, DEFAULT_MATERIAL)
        let pattern = Striped(WHITE, BLACK, scaling(2, 2, 2))
        let actualValue = pattern.colorAt(shape, point(1.5, 0, 0))
        let expectedValue = WHITE
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testStripePatternWithBothTransformations() throws {
        let shape = Sphere(scaling(2, 2, 2), DEFAULT_MATERIAL)
        let pattern = Striped(WHITE, BLACK, translation(0.5, 0, 0))
        let actualValue = pattern.colorAt(shape, point(2.5, 0, 0))
        let expectedValue = WHITE
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }
}
