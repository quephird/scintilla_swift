//
//  Camera.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/23/21.
//

import Foundation

struct Camera {
    var horizontalSize: Int
    var verticalSize: Int
    var fieldOfView: Double
    var viewTransform: Matrix4
    var inverseViewTransform: Matrix4
    var halfWidth: Double
    var halfHeight: Double
    var pixelSize: Double

    init(_ horizontalSize: Int, _ verticalSize: Int, _ fieldOfView: Double, _ viewTransform: Matrix4) {
        self.horizontalSize = horizontalSize
        self.verticalSize = verticalSize
        self.fieldOfView = fieldOfView
        self.viewTransform = viewTransform
        self.inverseViewTransform = viewTransform.inverse()

        let halfView = tan(fieldOfView/2)
        let aspectRatio = Double(horizontalSize) / Double(verticalSize)
        var halfWidth: Double
        var halfHeight: Double
        if aspectRatio >= 1 {
            halfWidth = halfView
            halfHeight = halfView / aspectRatio
        } else {
            halfWidth = halfView * aspectRatio
            halfHeight = halfView
        }
        let pixelSize = halfWidth * 2.0 / Double(horizontalSize)

        self.halfWidth = halfWidth
        self.halfHeight = halfHeight
        self.pixelSize = pixelSize
    }

    func rayForPixel(_ pixelX: Int, _ pixelY: Int) -> Ray {
        // The offset from the edge of the canvas to the pixel's center
        let offsetX = (Double(pixelX) + 0.5) * self.pixelSize
        let offsetY = (Double(pixelY) + 0.5) * self.pixelSize

        // The untransformed coordinates of the pixel in world space.
        // (Remember that the camera looks toward -z, so +x is to the *left*.)
        let worldX = self.halfWidth - offsetX
        let worldY = self.halfHeight - offsetY

        // Using the camera matrix, transform the canvas point and the origin,
        // and then compute the ray's direction vector.
        // (Remember that the canvas is at z=-1)
        let pixel = self.inverseViewTransform.multiplyTuple(point(worldX, worldY, -1))
        let origin = self.inverseViewTransform.multiplyTuple(point(0, 0, 0))
        let direction = pixel.subtract(origin).normalize()

        return Ray(origin, direction)
    }

    func render(_ world: World) -> Canvas {
        var canvas = Canvas(self.horizontalSize, self.verticalSize)
        for y in 0...self.verticalSize-1 {
            for x in 0...self.horizontalSize-1 {
                let ray = self.rayForPixel(x, y)
                let color = world.colorAt(ray)
                canvas.setPixel(x, y, color)
            }
        }
        return canvas
    }
}
