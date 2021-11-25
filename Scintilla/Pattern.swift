//
//  Pattern.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/24/21.
//

import Foundation

protocol Pattern {
    func colorAt(_ point: Tuple4) -> Color
}

struct Striped: Pattern {
    var firstColor: Color
    var secondColor: Color
    var transform: Matrix4

    init(_ firstColor: Color, _ secondColor: Color, _ transform: Matrix4) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.transform = transform
    }

    func colorAt(_ point: Tuple4) -> Color {
        if Int(floor(point.xyzw[0])) % 2 == 0 {
            return firstColor
        } else {
            return secondColor
        }
    }
}

struct Checkered3D: Pattern {
    var firstColor: Color
    var secondColor: Color
    var transform: Matrix4

    init(_ firstColor: Color, _ secondColor: Color, _ transform: Matrix4) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.transform = transform
    }

    func colorAt(_ point: Tuple4) -> Color {
        if Int(floor(point.xyzw[0]) + floor(point.xyzw[1]) + floor(point.xyzw[2])) % 2 == 0 {
            return firstColor
        } else {
            return secondColor
        }
    }
}
