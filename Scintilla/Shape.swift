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
    var inverseTransform: Matrix4

    init(_ transform: Matrix4) {
        self.id = Self.latestId
        self.transform = transform
        self.inverseTransform = transform.inverse()
        Self.latestId += 1
    }
}
