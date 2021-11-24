//
//  Sphere.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

class Sphere: Shape, Traceable {
    func intersect(_ worldRay: Ray) -> [Intersection] {
        let localRay = worldRay.transform(self.inverseTransform)

        // The vector from the sphere's center, to the ray origin
        // remember: the sphere is centered at the world origin
        let sphereToRay = localRay.origin.subtract(point(0, 0, 0))

        let a = localRay.direction.dot(localRay.direction)
        let b = 2 * localRay.direction.dot(sphereToRay)
        let c = sphereToRay.dot(sphereToRay) - 1
        let discriminant = b*b - 4*a*c

        if discriminant < 0 {
            return []
        } else if discriminant == 0 {
            return [Intersection(-b/2/a, self)]
        } else {
            return [
                Intersection((-b - sqrt(discriminant))/2/a, self),
                Intersection((-b + sqrt(discriminant))/2/a, self)
            ]
        }
    }

    func normal(_ worldPoint: Tuple4) -> Tuple4 {
        let localPoint = self.inverseTransform.multiplyTuple(worldPoint)
        let localNormal = localPoint.subtract(point(0, 0, 0))
        var worldNormal = self.inverseTransform.transpose().multiplyTuple(localNormal)
        worldNormal.xyzw[3] = 0.0;
        return worldNormal.normalize()
    }

    func getMaterial() -> Material {
        self.material
    }

    func getId() -> Int {
        self.id
    }
}
