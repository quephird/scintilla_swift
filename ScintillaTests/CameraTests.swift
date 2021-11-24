//
//  CameraTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/23/21.
//

import XCTest

class CameraTests: XCTestCase {
    func testPixelSizeForHorizontalCanvas() throws {
        let camera = Camera(200, 125, PI/2, IDENTITY4)
        let actualValue = camera.pixelSize
        let expectedValue = 0.01
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testPixelSizeForVerticalCanvas() throws {
        let camera = Camera(125, 200, PI/2, IDENTITY4)
        let actualValue = camera.pixelSize
        let expectedValue = 0.01
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testRayForPixelForCenterOfCanvas() throws {
        let camera = Camera(201, 101, PI/2, IDENTITY4)
        let ray = camera.rayForPixel(100, 50)
        XCTAssert(ray.origin.isAlmostEqual(point(0, 0, 0)))
        XCTAssert(ray.direction.isAlmostEqual(point(0, 0, -1)))
    }

    func testRayForPixelForCornerOfCanvas() throws {
        let camera = Camera(201, 101, PI/2, IDENTITY4)
        let ray = camera.rayForPixel(0, 0)
        XCTAssert(ray.origin.isAlmostEqual(point(0, 0, 0)))
        XCTAssert(ray.direction.isAlmostEqual(point(0.66519, 0.33259, -0.66851)))
    }

    func testRayForPixelForTransformedCamera() throws {
        let transform = rotationY(PI/4).multiplyMatrix(translation(0, -2, 5))
        let camera = Camera(201, 101, PI/2, transform)
        let ray = camera.rayForPixel(100, 50)
        XCTAssert(ray.origin.isAlmostEqual(point(0, 2, -5)))
        XCTAssert(ray.direction.isAlmostEqual(point(sqrt(2)/2, 0, -sqrt(2)/2)))
    }

    func testRender() throws {
        let world = DEFAULT_WORLD

        let from = point(0, 0, -5)
        let to = point(0, 0, 0)
        let up = vector(0, 1, 0)
        let viewTransform = view(from, to, up)
        let camera = Camera(11, 11, PI/2, viewTransform)

        let canvas = camera.render(world)
        let actualValue = canvas.getPixel(5, 5)
        let expectedValue = Color(0.38066, 0.47583, 0.2855)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}
