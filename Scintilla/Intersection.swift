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

    func prepareComputations(_ ray: Ray) -> Computations {
        let point = ray.position(self.t)
        let eye = ray.direction.negate()
        let normal = self.shape.normal(point)
        return Computations(
            t: self.t,
            object: self.shape,
            point: point,
            eye: eye,
            normal: normal
        )
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
