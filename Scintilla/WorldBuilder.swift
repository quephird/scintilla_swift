//
//  WorldBuilder.swift
//  Scintilla
//
//  Created by Danielle Kefford on 9/15/22.
//

@resultBuilder
enum WorldBuilder {
    static func buildBlock(_ light: Light, _ camera: Camera, _ shapes: Shape...) -> (Light, Camera, [Shape]) {
        return (light, camera, shapes)
    }
}
