//
// Created by Danielle Kefford on 11/21/21.
//

import XCTest

class Matrix2Tests: XCTestCase {
    func testDeterminant() throws {
        let m = Matrix2(
            1, 5,
            -3, 2
        )
        let actualValue = m.determinant()
        let expectedValue = 17.0
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}

class Matrix3Tests: XCTestCase {
    func testSubmatrix() throws {
        let m = Matrix3(
            1, 5, 0,
            -3, 2, 7,
            0, 6, -3
        )
        let actualValue = m.submatrix(0, 2)
        print(actualValue)
        let expectedValue = Matrix2(
            -3, 2,
            0, 6
        )
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testMinor() throws {
        let m = Matrix3(
            3, 5, 0,
            2, -1, -7,
            6, -1, 5
        )
        let actualValue = m.minor(1, 0)
        let expectedValue = 25.0
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testCofactor() throws {
        let m = Matrix3(
            3, 5, 0,
            2, -1, -7,
            6, -1, 5
        )
        let actualValue = m.cofactor(0, 0)
        let expectedValue = -12.0
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testDeterminant() throws {
        let m = Matrix3(
            1, 2, 6,
            -5, 8, -4,
            2, 6, 4
        )
        let actualValue = m.determinant()
        let expectedValue = -196.0
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}

class Matrix4Tests: XCTestCase {
    func testIsAlmostEqual() throws {
        let m1 = Matrix4(
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 8, 7, 6,
            5, 4, 3, 2
        )
        let m2 = Matrix4(
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 8, 7, 6,
            5, 4, 3, 2
        )
        XCTAssert(m1.isAlmostEqual(m2))
    }

    func testMultiplyMatrix() throws {
        let m1 = Matrix4(
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 8, 7, 6,
            5, 4, 3, 2
        )
        let m2 = Matrix4(
            -2, 1, 2, 3,
            3, 2, 1, -1,
            4, 3, 6, 5,
            1, 2, 7, 8
        )
        let expectedValue = Matrix4(
            20, 22, 50, 48,
            44, 54, 114, 108,
            40, 58, 110, 102,
            16, 26, 46, 42
        )
        let actualValue = m1.multiplyMatrix(m2)
        print(actualValue)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testMultiplyTuple() throws {
        let m = Matrix4(
            1, 2, 3, 4,
            2, 4, 4, 2,
            8, 6, 4, 1,
            0, 0, 0, 1
        )
        let t = Tuple4(1, 2, 3, 1)
        let actualValue = m.multiplyTuple(t)
        let expectedValue = Tuple4(18, 24, 33, 1)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testTranspose() throws {
        let m = Matrix4(
            0, 9, 3, 0,
            9, 8, 0, 8,
            1, 8, 5, 3,
            0, 0, 5, 8
        )
        let actualValue = m.transpose()
        let expectedValue = Matrix4(
            0, 9, 1, 0,
            9, 8, 8, 0,
            3, 0, 5, 5,
            0, 8, 3, 8
        )
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testSubmatrix() throws {
        let m = Matrix4(
            -6, 1, 1, 6,
            -8, 5, 8, 6,
            -1, 0, 8, 2,
            -7, 1, -1, 1
        )
        let actualValue = m.submatrix(2, 1)
        print(actualValue)
        let expectedValue = Matrix3(
            -6, 1, 6,
            -8, 8, 6,
            -7, -1, 1
        )
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testDeterminant() throws {
        let m = Matrix4(
            -2, -8, 3, 5,
            -3, 1, 7, 3,
            1, 2, -9, 6,
            -6, 7, 7, -9
        )
        let actualValue = m.determinant()
        let expectedValue = -4071.0
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testInverse() throws {
        let m = Matrix4(
            8, -5, 9, 2,
            7, 5, 6, 1,
            -6, 0, 9, 6,
            -3, 0, -9, -4
        )
        let actualValue = m.inverse()
        print(actualValue)
        let expectedValue = Matrix4(
            -0.15385, -0.15385, -0.28205, -0.53846,
            -0.07692, 0.12308, 0.02564, 0.03077,
            0.35897, 0.35897, 0.43590, 0.92308,
            -0.69231, -0.69231, -0.76923, -1.92308
        )
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}
