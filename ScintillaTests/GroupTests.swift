//
//  GroupTests.swift
//  ScintillaTests
//
//  Created by Danielle Kefford on 11/30/21.
//

import XCTest

class GroupTests: XCTestCase {
    func testLocalIntersectWithEmptyGroup() throws {
        let group = Group(IDENTITY4, DEFAULT_MATERIAL)
        let ray = Ray(point(0, 0, 0), vector(0, 0, 1))
        let allIntersections = group.localIntersect(ray)
        XCTAssertEqual(allIntersections.count, 0)
    }

    func testLocalIntersectWithNonEmptyGroup() throws {
        let group = Group(IDENTITY4, DEFAULT_MATERIAL)
        let s1 = Sphere(IDENTITY4, DEFAULT_MATERIAL)
        let s2 = Sphere(translation(0, 0, -3), DEFAULT_MATERIAL)
        let s3 = Sphere(translation(5, 0, 0), DEFAULT_MATERIAL)
        group.addChild(s1)
        group.addChild(s2)
        group.addChild(s3)

        let ray = Ray(point(0, 0, -5), vector(0, 0, 1))
        let allIntersections = group.localIntersect(ray)
        XCTAssertEqual(allIntersections.count, 4)
        XCTAssertEqual(allIntersections[0].shape.id, s2.id)
        XCTAssertEqual(allIntersections[1].shape.id, s2.id)
        XCTAssertEqual(allIntersections[2].shape.id, s1.id)
        XCTAssertEqual(allIntersections[3].shape.id, s1.id)
    }

    func testLocalIntersectWithTransformedGroup() throws {
        let groupTransform = scaling(2, 2, 2)
        let group = Group(groupTransform, DEFAULT_MATERIAL)
        let s = Sphere(translation(5, 0, 0), DEFAULT_MATERIAL)
        group.addChild(s)

        let ray = Ray(point(10, 0, -10), vector(0, 0, 1))
        let allIntersections = group.intersect(ray)
        XCTAssertEqual(allIntersections.count, 2)
    }
}
