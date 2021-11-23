//
//  SphereTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/22/21.
//

import XCTest

class SphereTests: XCTestCase {
    func testIntersectTangent() throws {
        let r = Ray(point(0, 1, -5), vector(0, 0, 1))
        let transform = IDENTITY4
        let s = Sphere(transform)
        let intersections = s.intersect(r)
        XCTAssertEqual(intersections.count, 1)
        XCTAssert(intersections[0].t.isAlmostEqual(5.0))
    }

    func testIntersectMiss() throws {
        let r = Ray(point(0, 2, -5), vector(0, 0, 1))
        let transform = IDENTITY4
        let s = Sphere(transform)
        let intersections = s.intersect(r)
        XCTAssertEqual(intersections.count, 0)
    }

    func testIntersectInside() throws {
        let r = Ray(point(0, 0, 0), vector(0, 0, 1))
        let transform = IDENTITY4
        let s = Sphere(transform)
        let intersections = s.intersect(r)
        XCTAssertEqual(intersections.count, 2)
        XCTAssert(intersections[0].t.isAlmostEqual(-1.0))
        XCTAssert(intersections[1].t.isAlmostEqual(1.0))
    }

    func testIntersectSphereBehind() throws {
        let r = Ray(point(0, 0, 5), vector(0, 0, 1))
        let transform = IDENTITY4
        let s = Sphere(transform)
        let intersections = s.intersect(r)
        XCTAssertEqual(intersections.count, 2)
        XCTAssert(intersections[0].t.isAlmostEqual(-6.0))
        XCTAssert(intersections[1].t.isAlmostEqual(-4.0))
    }

    func testIntersectScaledSphere() throws {
        let worldRay = Ray(point(0, 0, -5), vector(0, 0, 1))
        let transform = scaling(2, 2, 2)
        let s = Sphere(transform)
        let intersections = s.intersect(worldRay)
        XCTAssertEqual(intersections.count, 2)
        XCTAssert(intersections[0].t.isAlmostEqual(3))
        XCTAssert(intersections[1].t.isAlmostEqual(7))
    }

    func testIntersectTranslatedSphere() throws {
        let worldRay = Ray(point(0, 0, -5), vector(0, 0, 1))
        let transform = translation(5, 0, 0)
        let s = Sphere(transform)
        let intersections = s.intersect(worldRay)
        XCTAssertEqual(intersections.count, 0)
    }
}
