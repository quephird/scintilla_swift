//
//  Tuple.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

typealias Tuple = Array<Double>

func point(_ x: Double, _ y: Double, _ z: Double) -> Array<Double> {
    [x, y, z, 1.0]
}

func vector(_ x: Double, _ y: Double, _ z: Double) -> Array<Double> {
    [x, y, z, 0.0]
}

extension Tuple {
    func add(_ other: Self) -> Self {
        [self[0]+other[0], self[1]+other[1], self[2]+other[2], self[3]+other[3]]
    }

    func subtract(_ other: Self) -> Self {
        [self[0]-other[0], self[1]-other[1], self[2]-other[2], self[3]-other[3]]
    }

    func negate() -> Self {
        [-self[0], -self[1], -self[2], -self[3]]
    }

    func multiply_scalar(_ scalar: Double) -> Self {
        [scalar*self[0], scalar*self[1], scalar*self[2], scalar*self[3]]
    }

    func divide_scalar(_ scalar: Double) -> Self {
        [self[0]/scalar, self[1]/scalar, self[2]/scalar, self[3]/scalar]
    }

    func magnitude() -> Double {
        (self[0]*self[0] + self[1]*self[1] + self[2]*self[2] + self[3]*self[3]).squareRoot()
    }

    func normalize() -> Self {
        self.divide_scalar(self.magnitude())
    }

    func dot(_ other: Self) -> Double {
        self[0]*other[0] + self[1]*other[1] + self[2]*other[2] + self[3]*other[3]
    }

    func cross(_ other: Self) -> Self {
        vector(self[1] * other[2] - self[2] * other[1],
               self[2] * other[0] - self[0] * other[2],
               self[0] * other[1] - self[1] * other[0])
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self[0].isAlmostEqual(to[0]) &&
            self[1].isAlmostEqual(to[1]) &&
            self[2].isAlmostEqual(to[2]) &&
            self[3].isAlmostEqual(to[3])
    }
}
