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

    func testShadeHitIntersectionInShadow() throws {
        let light = Light(point(0, 0, -10), Color(1, 1, 1))
        let s1 = Sphere(IDENTITY4, DEFAULT_MATERIAL)
        let transform = translation(0, 0, 10)
        let s2 = Sphere(transform, DEFAULT_MATERIAL)
        let world = World(light, [s1, s2])
        let ray = Ray(point(0, 0, 5), vector(0, 0, 1))
        let intersection = Intersection(4, s2)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.shadeHit(computations)
        let expectedValue = Color(0.1, 0.1, 0.1)
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
        let expectedValue = Color(0.8, 1.0, 0.6)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testIsShadowedPointAndLightNotCollinear() throws {
        let world = DEFAULT_WORLD
        let point = point(0, 10, 0)
        XCTAssertFalse(world.isShadowed(point))
    }

    func testIsShadowedObjectBetweenPointAndLight() throws {
        let world = DEFAULT_WORLD
        let point = point(10, -10, 10)
        XCTAssertTrue(world.isShadowed(point))
    }

    func testIsShadowedObjectBehindLight() throws {
        let world = DEFAULT_WORLD
        let point = point(-20, 20, -20)
        XCTAssertFalse(world.isShadowed(point))
    }

    func testIsShadowedObjectBehindPoint() throws {
        let world = DEFAULT_WORLD
        let point = point(-2, 2, -2)
        XCTAssertFalse(world.isShadowed(point))
    }

    func testReflectedColorForNonreflectiveMaterial() {
        let world = DEFAULT_WORLD
        let secondShape = world.objects[1]
        secondShape.material.ambient = 1

        let ray = Ray(point(0, 0, 0), vector(0, 0, 1))
        let intersection = Intersection(1, secondShape)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.reflectedColorAt(computations)
        let expectedValue = Color(0, 0, 0)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }
}
