//
//  Tuple.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

typealias Tuple = Array<Double>

struct Tuple4 {
    var x: Double
    var y: Double
    var z: Double
    var w: Double

    init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    func add(_ other: Self) -> Self {
        Tuple4(self.x+other.x, self.y+other.y, self.z+other.z, self.w+other.w)
    }

    func subtract(_ other: Self) -> Self {
        Tuple4(self.x-other.x, self.y-other.y, self.z-other.z, self.w-other.w)
    }

    func negate() -> Self {
        Tuple4(-self.x, -self.y, -self.z, -self.z)
    }

    func multiplyScalar(_ scalar: Double) -> Self {
        Tuple4(scalar*self.x, scalar*self.y, scalar*self.z, scalar*self.w)
    }

    func divideScalar(_ scalar: Double) -> Self {
        Tuple4(self.x/scalar, self.y/scalar, self.z/scalar, self.w/scalar)
    }

    func magnitude() -> Double {
        (self.x*self.x + self.y*self.y + self.z*self.z + self.w*self.w).squareRoot()
    }

    func normalize() -> Self {
        self.divideScalar(self.magnitude())
    }

    func dot(_ other: Self) -> Double {
        self.x*other.x + self.y*other.y + self.z*other.z + self.w*other.w
    }

    func cross(_ other: Self) -> Self {
        vector(
            self.y * other.z - self.z * other.y,
            self.z * other.x - self.x * other.z,
            self.x * other.y - self.y * other.x
        )
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.x.isAlmostEqual(to.x) &&
            self.y.isAlmostEqual(to.y) &&
            self.z.isAlmostEqual(to.z) &&
            self.w.isAlmostEqual(to.w)
    }
}

func point(_ x: Double, _ y: Double, _ z: Double) -> Tuple4 {
    Tuple4(x, y, z, 1.0)
}

func vector(_ x: Double, _ y: Double, _ z: Double) -> Tuple4 {
    Tuple4(x, y, z, 0.0)
}
