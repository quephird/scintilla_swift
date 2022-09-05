//
//  ShapeBuilder.swift
//  Scintilla
//
//  Created by Danielle Kefford on 9/4/22.
//

import Foundation

@resultBuilder
enum ShapeBuilder {
    static func buildBlock(_ matrices: Matrix4...) -> [Matrix4] {
        return matrices
    }
}
