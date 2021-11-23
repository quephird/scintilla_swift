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
let red = Color(1, 0, 0)

let transform = IDENTITY4
let shape = Sphere(transform)

// For each row of pixels in the canvas
for y in 0...canvasPixels-1 {
    // Compute the world y coordinate (top = +half, bottom = -half)
    let worldY = halfWallSize - pixelSize * Double(y)

    // For each pixel in the row
    for x in 0...canvasPixels-1 {
        // Compute the world x coordinate (left = -half, right = half)
        let worldX = -halfWallSize + pixelSize * Double(x)

        // Describe the point on the wall that the ray will target
        let position = point(worldX, worldY, wallZ)
        let worldRay = Ray(origin, position.subtract(origin).normalize())
        var intersections = shape.intersect(worldRay)

        // Match using an optional pattern.
        if case _? = hit(&intersections) {
            canvas.setPixel(x, y, red)
        }
    }
}

let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("test.ppm")
try canvas.toPPM().write(to: filePath, atomically: true, encoding: .utf8)
