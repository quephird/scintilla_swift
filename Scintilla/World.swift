//
//  World.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/23/21.
//

import Foundation

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

    func shadeHit(_ computations: Computations) -> Color {
        let material = computations.object.material
        let isShadowed = self.isShadowed(computations.overPoint)

        return material.lighting(
            self.light,
            computations.point,
            computations.eye,
            computations.normal,
            isShadowed
        )
    }

    func colorAt(_ ray: Ray) -> Color {
        var intersections = self.intersect(ray)
        let hit = hit(&intersections)
        switch hit {
        case .none:
            return BLACK
        case .some(let intersection):
            let computations = intersection.prepareComputations(ray)
            return self.shadeHit(computations)
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
            Material(Color(0.8, 1.0, 0.6), 0.1, 0.7, 0.2, 200.0)
        ),
        Sphere(
            scaling(0.5, 0.5, 0.5),
            DEFAULT_MATERIAL
        )
    ]
)
