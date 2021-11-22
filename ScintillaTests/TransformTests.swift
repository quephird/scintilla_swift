//
//  TransformTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/21/21.
//

import XCTest

class TransformTests: XCTestCase {
    func testTranslation() throws {
        let transform = translation(5, -3, 2)
        let p = point(-3, 4, 5)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(2, 1, 7)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testTranslationInverse() throws {
        let transform = translation(5, -3, 2).inverse()
        let p = point(-3, 4, 5)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(-8, 7, 3)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testTranslationDoesNotAffectVectors() throws {
        let transform = translation(5, -3, 2).inverse()
        let v = vector(-3, 4, 5)
        let actualValue = transform.multiplyTuple(v)
        XCTAssert(actualValue.isAlmostEqual(v))
    }
}
