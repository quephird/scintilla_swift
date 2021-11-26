//
//  Intersection.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

struct Intersection {
    var t: Double
    var shape: Shape

    init(_ t: Double, _ shape: Shape) {
        self.t = t
        self.shape = shape
    }

    func prepareComputations(_ ray: Ray) -> Computations {
        let point = ray.position(self.t)
        let eye = ray.direction.negate()
        var normal = self.shape.normal(point)
        var isInside: Bool
        if normal.dot(eye) < 0 {
            isInside = true
            normal = normal.negate()
        } else {
            isInside = false
        }
        let overPoint = point.add(normal.multiplyScalar(EPSILON))
        let reflected = ray.direction.reflect(normal)

        return Computations(
            t: self.t,
            object: self.shape,
            point: point,
            overPoint: overPoint,
            eye: eye,
            normal: normal,
            reflected: reflected,
            isInside: isInside
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
