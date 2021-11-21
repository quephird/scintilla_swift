//
//  Color.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

struct Color {
    var r: Double
    var g: Double
    var b: Double

    init(_ r: Double, _ g: Double, _ b: Double) {
        self.r = r
        self.g = g
        self.b = b
    }

    func add(_ other: Self) -> Self {
        Color(self.r+other.r, self.g+other.g, self.b+other.b)
    }

    func subtract(_ other: Self) -> Self {
        Color(self.r-other.r, self.g-other.g, self.b-other.b)
    }

    func multiply_scalar(_ scalar: Double) -> Self {
        Color(self.r*scalar, self.g*scalar, self.b*scalar)
    }

    func hadamard(_ other: Self) -> Self {
        Color(self.r*other.r, self.g*other.g, self.b*other.b)
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.r.isAlmostEqual(to.r) &&
            self.g.isAlmostEqual(to.g) &&
            self.b.isAlmostEqual(to.b)
    }
}
