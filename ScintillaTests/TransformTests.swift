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

    func testScalingPoint() throws {
        let transform = scaling(2, 3, 4)
        let p = point(-4, 6, 8)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(-8, 18, 32)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testScalingVector() throws {
        let transform = scaling(2, 3, 4)
        let v = vector(-4, 6, 8)
        let actualValue = transform.multiplyTuple(v)
        let expectedValue = vector(-8, 18, 32)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testScalingInverse() throws {
        let transform = scaling(2, 3, 4).inverse()
        let v = vector(-4, 6, 8)
        let actualValue = transform.multiplyTuple(v)
        let expectedValue = vector(-2, 2, 2)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testRotationX() throws {
        let p = point(0, 1, 0)
        let halfQuarter = rotationX(PI/4)
        let fullQuarter = rotationX(PI/2)

        var actualValue = halfQuarter.multiplyTuple(p)
        var expectedValue = point(0, sqrt(2)/2, sqrt(2)/2)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))

        actualValue = fullQuarter.multiplyTuple(p)
        expectedValue = point(0, 0, 1)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testRotationY() throws {
        let p = point(0, 0, 1)
        let halfQuarter = rotationY(PI/4)
        let fullQuarter = rotationY(PI/2)

        var actualValue = halfQuarter.multiplyTuple(p)
        var expectedValue = point(sqrt(2)/2, 0, sqrt(2)/2)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))

        actualValue = fullQuarter.multiplyTuple(p)
        expectedValue = point(1, 0, 0)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testRotationZ() throws {
        let p = point(0, 1, 0)
        let halfQuarter = rotationZ(PI/4)
        let fullQuarter = rotationZ(PI/2)

        var actualValue = halfQuarter.multiplyTuple(p)
        var expectedValue = point(-sqrt(2)/2, sqrt(2)/2, 0)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))

        actualValue = fullQuarter.multiplyTuple(p)
        expectedValue = point(-1, 0, 0)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingXy() throws {
        let transform = shearing(1, 0, 0, 0, 0, 0)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(5, 3, 4)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingXz() throws {
        let transform = shearing(0, 1, 0, 0, 0, 0)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(6, 3, 4)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingYx() throws {
        let transform = shearing(0, 0, 1, 0, 0, 0)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(2, 5, 4)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingYz() throws {
        let transform = shearing(0, 0, 0, 1, 0, 0)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(2, 7, 4)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingZx() throws {
        let transform = shearing(0, 0, 0, 0, 1, 0)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(2, 3, 6)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShearingZy() throws {
        let transform = shearing(0, 0, 0, 0, 0, 1)
        let p = point(2, 3, 4)
        let actualValue = transform.multiplyTuple(p)
        let expectedValue = point(2, 3, 7)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testChainingTransformations() throws {
        let p = point(1, 0, 1)
        let rx = rotationX(PI/2)
        let s = scaling(5, 5, 5)
        let t = translation(10, 5, 7)
        let fullTransform = t.multiplyMatrix(s).multiplyMatrix(rx)
        let actualValue = fullTransform.multiplyTuple(p)
        let expectedValue = point(15, 0, 7)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testViewWithDefaultOrientation() throws {
        let from = point(0, 0, 0)
        let to = point(0, 0, -1)
        let up = vector(0, 1, 0)
        let actualValue = view(from, to, up)
        let expectedValue = IDENTITY4
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testViewLookingInPostiveZDirection() throws {
        let from = point(0, 0, 0)
        let to = point(0, 0, 1)
        let up = vector(0, 1, 0)
        let actualValue = view(from, to, up)
        let expectedValue = scaling(-1, 1, -1)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testViewMovesWorld() throws {
        let from = point(0, 0, 8)
        let to = point(0, 0, 1)
        let up = vector(0, 1, 0)
        let actualValue = view(from, to, up)
        let expectedValue = translation(0, 0, 8)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testViewArbitraryTransformation() throws {
        let from = point(1, 3, 2)
        let to = point(4, -2, 8)
        let up = vector(1, 1, 0)
        let actualValue = view(from, to, up)
        let expectedValue = Matrix4(
            -0.50709, 0.50709, 0.67612,  -2.36643,
            0.76772,  0.60609, 0.12122,  -2.82843,
            -0.35857, 0.59761, -0.71714, 0.00000,
            0.00000,  0.00000, 0.00000,  1.00000
        )
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}
