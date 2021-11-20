//
//  TupleTests.swift
//  TupleTests
//
//  Created by Danielle Kefford on 11/19/21.
//

import XCTest

class TupleTests: XCTestCase {
    func testTupleAdd() throws {
        let t1 = [3.0, -2.0, 5.0, 1.0]
        let t2 = [-2.0, 3.0, 1.0, 0.0]
        XCTAssertEqual(t1.add(t2), [1.0, 1.0, 6.0, 1.0])
    }

    func testTupleSubtractTwoPoints() throws {
        let p1 = point(3.0, 2.0, 1.0)
        let p2 = point(5.0, 6.0, 7.0)
        XCTAssertEqual(p1.subtract(p2), vector(-2.0, -4.0, -6.0))
    }

    func testTupleSubtractVectorFromPoint() throws {
        let p = point(3, 2, 1)
        let v = vector(5, 6, 7)
        XCTAssertEqual(p.subtract(v), point(-2, -4, -6))
    }

    func testTupleSubtractTwoVectors() throws {
        let v1 = vector(3, 2, 1)
        let v2 = vector(5, 6, 7)
        XCTAssertEqual(v1.subtract(v2), vector(-2, -4, -6))
    }

    func testNegate() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.negate(), [-1.0, 2.0, -3.0, 4.0])
    }

    func testMultiplyScalar() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.multiply_scalar(3.5), [3.5, -7.0, 10.5, -14.0])
    }

    func testMultiplyScalarFraction() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.multiply_scalar(0.5), [0.5, -1.0, 1.5, -2.0])
    }

    func testDivideScalar() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.divide_scalar(2), [0.5, -1.0, 1.5, -2.0])
    }

    func testMagnitude() throws {
        let v = vector(1, 2, 3)
        XCTAssertEqual(v.magnitude(), 14.0.squareRoot())
    }

    func testNormalize() throws {
        let v1 = vector(4, 0, 0)
        XCTAssertEqual(v1.normalize(), vector(1, 0, 0))

        let v2 = vector(1, 2, 3)
        let normalizedV2 = v2.normalize()
        XCTAssert(normalizedV2.isAlmostEqual(vector(0.26726, 0.53452, 0.80178)))
        XCTAssert(normalizedV2.magnitude().isAlmostEqual(1.0))
    }

    func testDot() throws {
        let v1 = vector(1, 2, 3)
        let v2 = vector(2, 3, 4)
        XCTAssertEqual(v1.dot(v2), 20.0)
    }

    func testCross() throws {
        let v1 = vector(1, 2, 3)
        let v2 = vector(2, 3, 4)
        XCTAssertEqual(v1.cross(v2), vector(-1, 2, -1))
        XCTAssertEqual(v2.cross(v1), vector(1, -2, 1))
    }
}
