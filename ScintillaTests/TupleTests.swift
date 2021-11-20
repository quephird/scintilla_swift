//
//  ScintillaTests.swift
//  ScintillaTests
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

    func testMultipleScalar() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.multiply_scalar(3.5), [3.5, -7.0, 10.5, -14.0])
    }

    func testMultipleScalarFraction() throws {
        let t = [1.0, -2.0, 3.0, -4.0]
        XCTAssertEqual(t.multiply_scalar(0.5), [0.5, -1.0, 1.5, -2.0])
    }
}
