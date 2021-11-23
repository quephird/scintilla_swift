//
//  Intersection.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

struct Intersection {
    var t: Double
    var shape: Traceable

    init(_ t: Double, _ shape: Traceable) {
        self.t = t
        self.shape = shape
    }
}

func hit(_ intersections: inout [Intersection]) -> Optional<Intersection> {
    intersections
        .sort(by: { i1, i2 in
            i1.t < i2.t
        })
    return intersections
        .filter({intersection in intersection.t > 0})
        .first
}
