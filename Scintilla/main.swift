//
//  main.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation


// Start the ray at z = -5
let origin = point(0, 0, -5)

// Put the wall at z = 10
let wallZ = 10.0

let wallSize = 7.0
let canvasPixels = 200
let pixelSize = wallSize/Double(canvasPixels)
let halfWallSize = wallSize/2

var canvas = Canvas(canvasPixels, canvasPixels)

// Scene setup
let transform = IDENTITY4
let material = Material(Color(1, 0.2, 1), 0.1, 0.9, 0.9, 200)
let shape = Sphere(transform, material)

let light = Light(point(-10, 10, -10), Color(1, 1, 1))

// For each row of pixels in the canvas...
for y in 0...canvasPixels-1 {
    // Compute the world y coordinate (top = +half, bottom = -half)
    let worldY = halfWallSize - pixelSize * Double(y)

    // For each pixel in the row...
    for x in 0...canvasPixels-1 {
        // Compute the world x coordinate (left = -half, right = half)
        let worldX = -halfWallSize + pixelSize * Double(x)

        // Describe the point on the wall that the ray will target
        let position = point(worldX, worldY, wallZ)
        let worldRay = Ray(origin, position.subtract(origin).normalize())
        var intersections = shape.intersect(worldRay)

        // Match using an optional pattern.
        if case let hit? = hit(&intersections) {
            let point = worldRay.position(hit.t)
            let normal = hit.shape.normal(point)
            let eye = worldRay.direction.negate()
            let objectMaterial = hit.shape.getMaterial()
            let color = objectMaterial.lighting(light, point, eye, normal)

            canvas.setPixel(x, y, color)
        }
    }
}

let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("test.ppm")
try canvas.toPPM().write(to: filePath, atomically: true, encoding: .utf8)
