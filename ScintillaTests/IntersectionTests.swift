//
//  IntersectionTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/22/21.
//

import XCTest

class IntersectionTests: XCTestCase {
    func testHitIntersectionsWithAllPositiveTs() throws {
        let transform = IDENTITY4
        let material = DEFAULT_MATERIAL
        let s = Sphere(transform, material)
        let i1 = Intersection(1, s)
        let i2 = Intersection(2, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i1.t))
    }

    func testHitIntersectionsWithSomeNegativeTs() throws {
        let transform = IDENTITY4
        let material = DEFAULT_MATERIAL
        let s = Sphere(transform, material)
        let i1 = Intersection(-1, s)
        let i2 = Intersection(1, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i2.t))
    }

    func testHitIntersectionsWithAllNegativeTs() throws {
        let transform = IDENTITY4
        let material = DEFAULT_MATERIAL
        let s = Sphere(transform, material)
        let i1 = Intersection(-2, s)
        let i2 = Intersection(-1, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)
        XCTAssertNil(h)
    }

    func testHitReturnsLowestNonnegativeIntersection() throws {
        let transform = IDENTITY4
        let material = DEFAULT_MATERIAL
        let s = Sphere(transform, material)
        let i1 = Intersection(5, s)
        let i2 = Intersection(7, s)
        let i3 = Intersection(-3, s)
        let i4 = Intersection(2, s)
        var intersections = [i1, i2, i3, i4]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i4.t))
    }

    func testPrepareComputationsOutside() throws {
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let shape = Sphere(IDENTITY4, DEFAULT_MATERIAL)
        let intersection = Intersection(4, shape)
        let computations = intersection.prepareComputations(ray, [intersection])
        XCTAssertEqual(computations.t, intersection.t)
        XCTAssertEqual(computations.object.id, shape.id)
        XCTAssert(computations.point.isAlmostEqual(point(0, 0, -1)))
        XCTAssert(computations.eye.isAlmostEqual(vector(0, 0, -1)))
        XCTAssert(computations.normal.isAlmostEqual(vector(0, 0, -1)))
        XCTAssertEqual(computations.isInside, false)
    }

    func testPrepareComputationsInside() throws {
        let ray = Ray(point(0, 0, 0), vector(0, 0, 1))
        let shape = Sphere(IDENTITY4, DEFAULT_MATERIAL)
        let intersection = Intersection(1, shape)
        let computations = intersection.prepareComputations(ray, [intersection])
        XCTAssertEqual(computations.t, intersection.t)
        XCTAssertEqual(computations.object.id, shape.id)
        XCTAssert(computations.point.isAlmostEqual(point(0, 0, 1)))
        XCTAssert(computations.eye.isAlmostEqual(vector(0, 0, -1)))
        XCTAssert(computations.normal.isAlmostEqual(vector(0, 0, -1)))
        XCTAssertEqual(computations.isInside, true)
    }

    func testPrepareComputationsHitShouldOffsetPoint() throws {
        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let transform = translation(0, 0, 1)
        let shape = Sphere(transform, DEFAULT_MATERIAL)
        let intersection = Intersection(5, shape)
        let computations = intersection.prepareComputations(ray, [intersection])
        XCTAssertTrue(computations.overPoint.xyzw[2] < -EPSILON/2)
        XCTAssertTrue(computations.point.xyzw[2] > computations.overPoint.xyzw[2])
    }

    func testPrepareComputationsReflected() throws {
        let shape = Plane(IDENTITY4, DEFAULT_MATERIAL)
        let ray = Ray(point(0, 1, -1), vector(0, -sqrt(2)/2, sqrt(2)/2))
        let intersection = Intersection(sqrt(2), shape)
        let computations = intersection.prepareComputations(ray, [intersection])
        XCTAssertTrue(computations.reflected.isAlmostEqual(vector(0, sqrt(2)/2, sqrt(2)/2)))
    }
}
