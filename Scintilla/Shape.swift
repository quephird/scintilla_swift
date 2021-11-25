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
    var inverseTransposeTransform: Matrix4

    init(_ transform: Matrix4, _ material: Material) {
        self.id = Self.latestId
        self.transform = transform
        self.material = material
        self.inverseTransform = transform.inverse()
        self.inverseTransposeTransform = transform.inverse().transpose()
        Self.latestId += 1
    }

    func intersect(_ worldRay: Ray) -> [Intersection] {
        let localRay = worldRay.transform(self.inverseTransform)
        return self.localIntersect(localRay)
    }

    func localIntersect(_ localRay: Ray) -> [Intersection] {
        fatalError("Subclasses must override this method!")
    }

    func normal(_ worldPoint: Tuple4) -> Tuple4 {
        let localPoint = self.inverseTransform.multiplyTuple(worldPoint)
        let localNormal = self.localNormal(localPoint)
        var worldNormal = self.inverseTransposeTransform.multiplyTuple(localNormal)
        worldNormal.xyzw[3] = 0.0;
        return worldNormal.normalize()
    }

    func localNormal(_ point: Tuple4) -> Tuple4 {
        fatalError("Subclasses must override this method!")
    }
}
