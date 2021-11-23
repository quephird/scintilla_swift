//
//  Tuple.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

struct Tuple2 {
    var xy: [Double]

    init(_ x: Double, _ y: Double) {
        self.xy = [x, y]
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.xy[0].isAlmostEqual(to.xy[0]) &&
            self.xy[1].isAlmostEqual(to.xy[1])
    }
}

struct Tuple3 {
    var xyz: [Double]

    init(_ x: Double, _ y: Double, _ z: Double) {
        self.xyz = [x, y, z]
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.xyz[0].isAlmostEqual(to.xyz[0]) &&
            self.xyz[1].isAlmostEqual(to.xyz[1]) &&
            self.xyz[2].isAlmostEqual(to.xyz[2])
    }
}

struct Tuple4 {
    var xyzw: [Double]

    init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.xyzw = [x, y, z, w]
    }

    func add(_ other: Self) -> Self {
        Tuple4(
            self.xyzw[0]+other.xyzw[0],
            self.xyzw[1]+other.xyzw[1],
            self.xyzw[2]+other.xyzw[2],
            self.xyzw[3]+other.xyzw[3]
        )
    }

    func subtract(_ other: Self) -> Self {
        Tuple4(
            self.xyzw[0]-other.xyzw[0],
            self.xyzw[1]-other.xyzw[1],
            self.xyzw[2]-other.xyzw[2],
            self.xyzw[3]-other.xyzw[3]
        )
    }

    func negate() -> Self {
        Tuple4(-self.xyzw[0], -self.xyzw[1], -self.xyzw[2], -self.xyzw[3])
    }

    func multiplyScalar(_ scalar: Double) -> Self {
        Tuple4(
            scalar*self.xyzw[0],
            scalar*self.xyzw[1],
            scalar*self.xyzw[2],
            scalar*self.xyzw[3]
        )
    }

    func divideScalar(_ scalar: Double) -> Self {
        Tuple4(
            self.xyzw[0]/scalar,
            self.xyzw[1]/scalar,
            self.xyzw[2]/scalar,
            self.xyzw[3]/scalar
        )
    }

    func magnitude() -> Double {
        (self.xyzw[0]*self.xyzw[0] +
            self.xyzw[1]*self.xyzw[1] +
            self.xyzw[2]*self.xyzw[2] +
            self.xyzw[3]*self.xyzw[3]).squareRoot()
    }

    func normalize() -> Self {
        self.divideScalar(self.magnitude())
    }

    func dot(_ other: Self) -> Double {
        self.xyzw[0]*other.xyzw[0] +
            self.xyzw[1]*other.xyzw[1] +
            self.xyzw[2]*other.xyzw[2] +
            self.xyzw[3]*other.xyzw[3]
    }

    func cross(_ other: Self) -> Self {
        vector(
            self.xyzw[1] * other.xyzw[2] - self.xyzw[2] * other.xyzw[1],
            self.xyzw[2] * other.xyzw[0] - self.xyzw[0] * other.xyzw[2],
            self.xyzw[0] * other.xyzw[1] - self.xyzw[1] * other.xyzw[0]
        )
    }

    func reflect(_ normal: Tuple4) -> Tuple4 {
        return self.subtract(normal.multiplyScalar(2 * self.dot(normal)))
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.xyzw[0].isAlmostEqual(to.xyzw[0]) &&
            self.xyzw[1].isAlmostEqual(to.xyzw[1]) &&
            self.xyzw[2].isAlmostEqual(to.xyzw[2]) &&
            self.xyzw[3].isAlmostEqual(to.xyzw[3])
    }
}

func point(_ x: Double, _ y: Double, _ z: Double) -> Tuple4 {
    Tuple4(x, y, z, 1.0)
}

func vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple4 {
    Tuple4(x, y, z, 0.0)
}
