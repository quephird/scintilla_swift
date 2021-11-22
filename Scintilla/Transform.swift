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
