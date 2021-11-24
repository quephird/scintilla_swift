//
//  World.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/23/21.
//

import Foundation

struct World {
    var light: Light
    var objects: [Traceable]

    init(_ light: Light, _ objects: [Traceable]) {
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