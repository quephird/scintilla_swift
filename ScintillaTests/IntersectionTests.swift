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
        let s = Sphere(transform)
        let i1 = Intersection(1, s)
        let i2 = Intersection(2, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i1.t))
    }

    func testHitIntersectionsWithSomeNegativeTs() throws {
        let transform = IDENTITY4
        let s = Sphere(transform)
        let i1 = Intersection(-1, s)
        let i2 = Intersection(1, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i2.t))
    }

    func testHitIntersectionsWithAllNegativeTs() throws {
        let transform = IDENTITY4
        let s = Sphere(transform)
        let i1 = Intersection(-2, s)
        let i2 = Intersection(-1, s)
        var intersections = [i2, i1]
        let h = hit(&intersections)
        XCTAssertNil(h)
    }

    func testHitReturnsLowestNonnegativeIntersection() throws {
        let transform = IDENTITY4
        let s = Sphere(transform)
        let i1 = Intersection(5, s)
        let i2 = Intersection(7, s)
        let i3 = Intersection(-3, s)
        let i4 = Intersection(2, s)
        var intersections = [i1, i2, i3, i4]
        let h = hit(&intersections)!
        XCTAssert(h.t.isAlmostEqual(i4.t))
    }
}
