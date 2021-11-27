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
        let actualValue = world.shadeHit(computations, MAX_RECURSIVE_CALLS)
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
        let actualValue = world.shadeHit(computations, MAX_RECURSIVE_CALLS)
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
        let actualValue = world.shadeHit(computations, MAX_RECURSIVE_CALLS)
        let expectedValue = Color(0.1, 0.1, 0.1)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtMiss() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 1, 0))
        let actualValue = world.colorAt(ray, MAX_RECURSIVE_CALLS)
        let expectedValue = Color(0, 0, 0)
        XCTAssert(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtHit() throws {
        let world = DEFAULT_WORLD
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let actualValue = world.colorAt(ray, MAX_RECURSIVE_CALLS)
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
        let actualValue = world.colorAt(ray, MAX_RECURSIVE_CALLS)
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
        let actualValue = world.reflectedColorAt(computations, MAX_RECURSIVE_CALLS)
        let expectedValue = Color(0, 0, 0)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testShadeHitWithReflectiveMaterial() throws {
        var world = DEFAULT_WORLD
        let transform = translation(0, -1, 0)
        var material = DEFAULT_MATERIAL
        material.reflective = 0.5
        let anotherShape = Plane(transform, material)
        world.objects.append(anotherShape)
        let ray = Ray(point(0, 0, -3), vector(0, -sqrt(2)/2, sqrt(2)/2))
        let intersection = Intersection(sqrt(2), anotherShape)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.shadeHit(computations, MAX_RECURSIVE_CALLS)
        let expectedValue = Color(0.87676, 0.92434, 0.82917)
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }

    func testColorAtTerminatesForWorldWithMutuallyReflectiveSurfaces() throws {
        let light = Light(point(0, 0, 0), Color(1, 1, 1))
        var material = DEFAULT_MATERIAL
        material.reflective = 1
        let lowerTransform = translation(0, -1, 0)
        let lowerPlane = Plane(lowerTransform, material)
        let upperTransform = translation(0, 1, 0)
        let upperPlane = Plane(upperTransform, material)
        let world = World(light, [lowerPlane, upperPlane])
        let ray = Ray(point(0, 0, 0), vector(0, 1, 0))
        // The following call should terminate; no need to test return value
        let color = world.colorAt(ray, MAX_RECURSIVE_CALLS)
    }

    func testColorAtMaxRecursiveDepth() throws {
        var world = DEFAULT_WORLD
        let transform = translation(0, -1, 0)
        var material = DEFAULT_MATERIAL
        material.reflective = 0.5
        let additionalShape = Plane(transform, material)
        world.objects.append(additionalShape)
        let ray = Ray(point(0, 0, -3), vector(0, -sqrt(2)/2, sqrt(2)/2))
        let intersection = Intersection(sqrt(2), additionalShape)
        let computations = intersection.prepareComputations(ray)
        let actualValue = world.reflectedColorAt(computations, 0)
        let expectedValue = BLACK
        XCTAssertTrue(actualValue.isAlmostEqual(expectedValue))
    }
}
