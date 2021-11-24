//
//  WorldTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/23/21.
//

import XCTest

class WorldTests: XCTestCase {
    func testIntersect() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let intersections = world.intersect(ray)
        XCTAssertEqual(intersections.count, 4)
        XCTAssert(intersections[0].t.isAlmostEqual(4))
        XCTAssert(intersections[1].t.isAlmostEqual(4.5))
        XCTAssert(intersections[2].t.isAlmostEqual(5.5))
        XCTAssert(intersections[3].t.isAlmostEqual(6))
    }

    func testShadeHit() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = world.objects[0]
        let intersection = Intersection(4, shape)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.shadeHit(computations)
        let expectedValue = Color(0.38066, 0.47583, 0.2855)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testShadeHitInside() throws {
        var world = DEFAULT_WORLD
        let light = Light(point(0, 0.25, 0), Color(1, 1, 1))
        world.light = light
        let ray = Ray(point(0, 0, 0), vector(0, 0, 1))
        let shape = world.objects[1]
        let intersection = Intersection(0.5, shape)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.shadeHit(computations)
        let expectedValue = Color(0.90498, 0.90498, 0.90498)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtMiss() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 1, 0))
        let actualValue = world.colorAt(ray)
        let expectedValue = Color(0, 0, 0)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtHit() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let actualValue = world.colorAt(ray)
        let expectedValue = Color(0.38066, 0.47583, 0.2855)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtIntersectionBehindRay() throws {
        let world = DEFAULT_WORLD
        let outerSphere = world.objects[0]
        outerSphere.material.ambient = 1
        let innerSphere = world.objects[0]
        innerSphere.material.ambient = 1
        let ray = Ray(point(0, 0, 0.75), vector(0, 0, -1))
        let actualValue = world.colorAt(ray)
        let expectedValue = innerSphere.material.color
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }
}
