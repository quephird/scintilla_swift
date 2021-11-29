//
//  Cube.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/27/21.
//

import Foundation

class Cube: Shape {
    func checkAxis(_ originComponent: Double, _ directionComponent: Double) -> (Double, Double) {
        let tMinNumerator = (-1 - originComponent)
        let tMaxNumerator = (1 - originComponent)

        var tMin: Double
        var tMax: Double
        if abs(directionComponent) >= EPSILON {
            tMin = tMinNumerator / directionComponent
            tMax = tMaxNumerator / directionComponent
        } else {
            tMin = tMinNumerator * .infinity
            tMax = tMaxNumerator * .infinity
        }

        if tMin > tMax {
            return (tMax, tMin)
        } else {
            return (tMin, tMax)
        }
    }

    override func localIntersect(_ localRay: Ray) -> [Intersection] {
        let (xTMin, xTMax) = self.checkAxis(localRay.origin.xyzw[0], localRay.direction.xyzw[0])
        let (yTMin, yTMax) = self.checkAxis(localRay.origin.xyzw[1], localRay.direction.xyzw[1])
        let (zTMin, zTMax) = self.checkAxis(localRay.origin.xyzw[2], localRay.direction.xyzw[2])

        let tMin = max(xTMin, yTMin, zTMin)
        let tMax = min(xTMax, yTMax, zTMax)

        if tMin > tMax {
            return []
        } else {
            return [
                Intersection(tMin, self),
                Intersection(tMax, self),
            ]
        }
    }

    override func localNormal(_ localPoint: Tuple4) -> Tuple4 {
        let maxComponent = max(abs(localPoint.xyzw[0]), abs(localPoint.xyzw[1]), abs(localPoint.xyzw[2]))

        if maxComponent == abs(localPoint.xyzw[0]) {
            return vector(localPoint.xyzw[0], 0, 0)
        } else if maxComponent == abs(localPoint.xyzw[1]) {
            return vector(0, localPoint.xyzw[1], 0)
        } else {
            return vector(0, 0, localPoint.xyzw[2])
        }
    }
}