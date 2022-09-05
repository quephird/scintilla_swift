//
//  WorldBuilder.swift
//  Scintilla
//
//  Created by Danielle Kefford on 9/4/22.
//

import Foundation

@resultBuilder
enum WorldBuilder {
    static func buildBlock(_ shapes: Shape...) -> [Shape] {
        return shapes
    }
}
