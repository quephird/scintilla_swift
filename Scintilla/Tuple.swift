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
        zip(self, other).map(+)
    }

    func subtract(_ other: Self) -> Self {
        zip(self, other).map(-)
    }

    func negate() -> Self {
        [-self[0], -self[1], -self[2], -self[3]]
    }

    func multiply_scalar(_ scalar: Double) -> Self {
        [scalar*self[0], scalar*self[1], scalar*self[2], scalar*self[3]]
    }
}
