//
//  World.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/23/21.
//

import Foundation

let MAX_RECURSIVE_CALLS = 5

struct World {
    var light: Light
    var objects: [Shape]

    init(_ light: Light, _ objects: [Shape]) {
        self.light = light
        self.objects = objects
    }

    func intersect(_ ray: Ray) -> [Intersection] {
        var intersections = objects.flatMap({object in object.intersect(ray)})
        intersections
            .sort(by: { i1, i2 in
                i1.t < i2.t
            })
        return intersections
    }

    func shadeHit(_ computations: Computations, _ remainingCalls: Int) -> Color {
        let material = computations.object.material
        let isShadowed = self.isShadowed(computations.overPoint)

        let materialColor = material.lighting(
            self.light,
            computations.object,
            computations.point,
            computations.eye,
            computations.normal,
            isShadowed
        )

        let reflectedColor = self.reflectedColorAt(computations, remainingCalls)
        return materialColor.add(reflectedColor)
    }

    func reflectedColorAt(_ computations: Computations, _ remainingCalls: Int) -> Color {
        if remainingCalls == 0 {
            return BLACK
        } else if computations.object.material.reflective == 0 {
            return Color(0, 0, 0)
        } else {
            let reflected = Ray(computations.overPoint, computations.reflected)
            return self.colorAt(reflected, remainingCalls-1).multiplyScalar(computations.object.material.reflective)
        }
    }

    func colorAt(_ ray: Ray, _ remainingCalls: Int) -> Color {
        var allIntersections = self.intersect(ray)
        let hit = hit(&allIntersections)
        switch hit {
        case .none:
            return BLACK
        case .some(let intersection):
            let computations = intersection.prepareComputations(ray, allIntersections)
            return self.shadeHit(computations, remainingCalls)
        }
    }

    func isShadowed(_ point: Tuple4) -> Bool {
        let lightVector = self.light.position.subtract(point)
        let lightDistance = lightVector.magnitude()
        let lightDirection = lightVector.normalize()
        let lightRay = Ray(point, lightDirection)
        var intersections = self.intersect(lightRay)
        let hit = hit(&intersections)

        if hit != nil && hit!.t < lightDistance {
            return true
        } else {
            return false
        }
    }
}

let DEFAULT_WORLD = World(
    Light(point(-10, 10, -10), Color(1, 1, 1)),
    [
        Sphere(
            IDENTITY4,
            Material(ColorStrategy.solidColor(Color(0.8, 1.0, 0.6)), 0.1, 0.7, 0.2, 200.0, 0.0, 0.0, 0.0)
        ),
        Sphere(
            scaling(0.5, 0.5, 0.5),
            DEFAULT_MATERIAL
        )
    ]
)
