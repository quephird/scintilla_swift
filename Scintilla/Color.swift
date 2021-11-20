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

    func add(_ other: Self) -> Self {
        Color(r: self.r+other.r, g: self.g+other.g, b: self.b+other.b)
    }

    func subtract(_ other: Self) -> Self {
        Color(r: self.r-other.r, g: self.g-other.g, b: self.b-other.b)
    }

    func multiply_scalar(_ scalar: Double) -> Self {
        Color(r: self.r*scalar, g: self.g*scalar, b: self.b*scalar)
    }

    func isAlmostEqual(_ to: Self) -> Bool {
        self.r.isAlmostEqual(to.r) &&
            self.g.isAlmostEqual(to.g) &&
            self.b.isAlmostEqual(to.b)
    }
}
