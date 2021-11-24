//
//  Shape.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

class Shape {
    static var latestId: Int = 0
    var id: Int
    var transform: Matrix4
    var material: Material
    var inverseTransform: Matrix4

    init(_ transform: Matrix4, _ material: Material) {
        self.id = Self.latestId
        self.transform = transform
        self.material = material
        self.inverseTransform = transform.inverse()
        Self.latestId += 1
    }

    func intersect(_ ray: Ray) -> [Intersection] {
        fatalError("Subclasses must override this method!")
    }

    func normal(_ point: Tuple4) -> Tuple4 {
        fatalError("Subclasses must override this method!")
    }
}
