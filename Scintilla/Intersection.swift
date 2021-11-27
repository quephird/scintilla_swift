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

    func prepareComputations(_ ray: Ray, _ allIntersections: [Intersection]) -> Computations {
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

        var n1 = 1.0
        var n2 = 1.0
//        var containers: [Shape]
//        for i ← each intersection in xs if i = hit then
//        if containers is empty comps.n1 ← 1.0
//        else
//        comps.n1 ← last(containers).material.refractive_index end if
//        end if
//        if containers includes i.object then remove i.object from containers
//        else
//            append i.object onto containers
//        end if
//            if i = hit then
//            if containers is empty
//            comps.n2 ← 1.0 else
//            comps.n2 ← last(containers).material.refractive_index end if
//                terminate loop
//            end if end for

        return Computations(
            t: self.t,
            object: self.shape,
            point: point,
            overPoint: overPoint,
            eye: eye,
            normal: normal,
            reflected: reflected,
            isInside: isInside,
            n1: n1,
            n2: n2
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
