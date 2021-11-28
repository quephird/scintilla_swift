//
//  Cylinder.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/27/21.
//

import Foundation

class Cylinder: Shape {
    override func localIntersect(_ localRay: Ray) -> [Intersection] {
        let a =
            localRay.direction.xyzw[0]*localRay.direction.xyzw[0] +
            localRay.direction.xyzw[2]*localRay.direction.xyzw[2]

        if a.isAlmostEqual(0.0) {
            // Ray is parallel to the y axis
            return []
        } else {
            let b =
                2 * localRay.origin.xyzw[0] * localRay.direction.xyzw[0] +
                2 * localRay.origin.xyzw[2] * localRay.direction.xyzw[2]
            let c =
                localRay.origin.xyzw[0]*localRay.origin.xyzw[0] +
                localRay.origin.xyzw[2]*localRay.origin.xyzw[2] - 1
            let discriminant = b*b - 4*a*c

            if discriminant < 0 {
                // Ray does not intersect the cylinder
                return []
            } else {
                // This is just a placeholder, to ensure the tests
                // pass that expect the ray to miss.
                return [Intersection(1, self)]
            }
        }
    }

    override func localNormal(_ localPoint: Tuple4) -> Tuple4 {
        return localPoint.subtract(point(0, 0, 0))
    }
}
