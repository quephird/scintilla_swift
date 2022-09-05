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
    var transform: Matrix4 {
        didSet {
            self.inverseTransform = transform.inverse()
            self.inverseTransposeTransform = transform.inverse().transpose()
        }
    }
    var material: Material
    var inverseTransform: Matrix4
    var inverseTransposeTransform: Matrix4
    var parent: Container?

    init(_ material: Material) {
        self.id = Self.latestId
        self.transform = .identity
        self.material = material
        self.inverseTransform = transform.inverse()
        self.inverseTransposeTransform = transform.inverse().transpose()
        Self.latestId += 1
    }

    func translate(_ x: Double, _ y: Double, _ z: Double) -> Self {
        self.transform = Matrix4(
            1, 0, 0, x,
            0, 1, 0, y,
            0, 0, 1, z,
            0, 0, 0, 1
        ).multiplyMatrix(self.transform)

        return self
    }

    func scale(_ x: Double, _ y: Double, _ z: Double) -> Self {
        self.transform = Matrix4(
            x, 0, 0, 0,
            0, y, 0, 0,
            0, 0, z, 0,
            0, 0, 0, 1
        ).multiplyMatrix(self.transform)

        return self
    }

    func rotateX(_ t: Double) -> Self {
        self.transform = Matrix4(
            1, 0,      0,       0,
            0, cos(t), -sin(t), 0,
            0, sin(t), cos(t),  0,
            0, 0,      0,       1
        ).multiplyMatrix(self.transform)

        return self
    }

    func rotateY(_ t: Double) -> Self {
        self.transform = Matrix4(
            cos(t),  0, sin(t), 0,
            0,       1, 0,      0,
            -sin(t), 0, cos(t), 0,
            0, 0,      0,       1
        ).multiplyMatrix(self.transform)

        return self
    }

    func rotateZ(_ t: Double) -> Self {
        self.transform = Matrix4(
            cos(t), -sin(t), 0, 0,
            sin(t), cos(t),  0, 0,
            0,      0,       1, 0,
            0,      0,       0, 1
        ).multiplyMatrix(self.transform)

        return self
    }

    func shear(_ xy: Double, _ xz: Double, _ yx: Double, _ yz: Double, _ zx: Double, _ zy: Double) -> Self {
        self.transform = Matrix4(
            1,  xy, xz, 0,
            yx, 1,  yz, 0,
            zx, zy, 1,  0,
            0,  0,  0,  1
        ).multiplyMatrix(self.transform)

        return self
    }

    func intersect(_ worldRay: Ray) -> [Intersection] {
        let localRay = worldRay.transform(self.inverseTransform)
        return self.localIntersect(localRay)
    }

    func localIntersect(_ localRay: Ray) -> [Intersection] {
        fatalError("Subclasses must override this method!")
    }

    func normal(_ worldPoint: Tuple4) -> Tuple4 {
        let localPoint = self.worldToObject(worldPoint)
        let localNormal = self.localNormal(localPoint)
        return self.objectToWorld(localNormal)
    }

    func localNormal(_ localPoint: Tuple4) -> Tuple4 {
        fatalError("Subclasses must override this method!")
    }

    func worldToObject(_ worldPoint: Tuple4) -> Tuple4 {
        var objectPoint = worldPoint
        if case .group(let group) = parent {
            objectPoint = group.worldToObject(worldPoint)
        } else if case .csg(let csg) = parent {
            objectPoint = csg.worldToObject(worldPoint)
        }
        return self.inverseTransform.multiplyTuple(objectPoint)
    }

    func objectToWorld(_ objectNormal: Tuple4) -> Tuple4 {
        var worldNormal = self.inverseTransposeTransform.multiplyTuple(objectNormal)
        worldNormal[3] = 0
        worldNormal = worldNormal.normalize()

        if case .group(let group) = parent {
            worldNormal = group.objectToWorld(worldNormal)
        } else if case .csg(let csg) = parent {
            worldNormal = csg.objectToWorld(worldNormal)
        }

        return worldNormal
    }

    func includes(_ other: Shape) -> Bool {
        switch self {
        case let group as Group:
            return group.children.contains(where: {shape in shape.includes(other)})
        case let csg as CSG:
            return csg.left.includes(other) || csg.right.includes(other)
        default:
            return self.id == other.id
        }
    }
}
