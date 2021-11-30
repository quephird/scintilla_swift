//
//  Transform.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/21/21.
//

import Foundation

func translation(_ x: Double, _ y: Double, _ z: Double) -> Matrix4 {
    Matrix4(
        1, 0, 0, x,
        0, 1, 0, y,
        0, 0, 1, z,
        0, 0, 0, 1
    )
}

func scaling(_ x: Double, _ y: Double, _ z: Double) -> Matrix4 {
    Matrix4(
        x, 0, 0, 0,
        0, y, 0, 0,
        0, 0, z, 0,
        0, 0, 0, 1
    )
}

func rotationX(_ t: Double) -> Matrix4 {
    Matrix4(
        1, 0,      0,       0,
        0, cos(t), -sin(t), 0,
        0, sin(t), cos(t),  0,
        0, 0,      0,       1
    )
}

func rotationY(_ t: Double) -> Matrix4 {
    Matrix4(
        cos(t),  0, sin(t), 0,
        0,       1, 0,      0,
        -sin(t), 0, cos(t), 0,
        0, 0,      0,       1
    )
}

func rotationZ(_ t: Double) -> Matrix4 {
    Matrix4(
        cos(t), -sin(t), 0, 0,
        sin(t), cos(t),  0, 0,
        0,      0,       1, 0,
        0,      0,       0, 1
    )
}

func shearing(_ xy: Double, _ xz: Double, _ yx: Double, _ yz: Double, _ zx: Double, _ zy: Double) -> Matrix4 {
    Matrix4(
        1,  xy, xz, 0,
        yx, 1,  yz, 0,
        zx, zy, 1,  0,
        0,  0,  0,  1
    )
}

func view(_ from: Tuple4, _ to: Tuple4, _ up: Tuple4) -> Matrix4 {
    let forward = to.subtract(from).normalize()
    let upNormalized = up.normalize()
    let left = forward.cross(upNormalized)
    let upTrue = left.cross(forward)
    let orientation = Matrix4(
        left[0],     left[1],     left[2],     0,
        upTrue[0],   upTrue[1],   upTrue[2],   0,
        -forward[0], -forward[1], -forward[2], 0,
        0,           0,           0,           1
    )
    let transform = translation(-from[0], -from[1], -from[2])
    return orientation.multiplyMatrix(transform)
}
