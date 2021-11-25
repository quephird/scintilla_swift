//
//  Material.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

struct Material {
    var colorStrategy: ColorStrategy
    var ambient: Double
    var diffuse: Double
    var specular: Double
    var shininess: Double

    init(_ colorStrategy: ColorStrategy, _ ambient: Double, _ diffuse: Double, _ specular: Double, _ shininess: Double) {
        self.colorStrategy = colorStrategy
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.shininess = shininess
    }

    func lighting(_ light: Light, _ object: Shape, _ point: Tuple4, _ eye: Tuple4, _ normal: Tuple4, _ isShadowed: Bool) -> Color {
        // Combine the surface color with the light's color/intensity
        var effectiveColor: Color
        switch self.colorStrategy {
        case .solidColor(let color):
            effectiveColor = color.hadamard(light.intensity)
        case .pattern(let pattern):
            effectiveColor = pattern.colorAt(object, point)
        }

        // Find the direction to the light source
        let lightDirection = light.position.subtract(point).normalize()

        // Compute the ambient contribution
        let ambient = effectiveColor.multiplyScalar(self.ambient)

        // light_dot_normal represents the cosine of the angle between the
        // light vector and the normal vector. A negative number means the
        // light is on the other side of the surface.
        let lightDotNormal = lightDirection.dot(normal)

        var diffuse: Color
        var specular: Color
        if lightDotNormal < 0 || isShadowed == true {
            diffuse = BLACK
            specular = BLACK
        } else {
            // Compute the diffuse contribution
            diffuse = effectiveColor.multiplyScalar(self.diffuse * lightDotNormal)

            // reflect_dot_eye represents the cosine of the angle between the
            // reflection vector and the eye vector. A negative number means the
            // light reflects away from the eye.
            let reflected = lightDirection.negate().reflect(normal)
            let reflectDotEye = reflected.dot(eye)

            if reflectDotEye <= 0 {
                specular = BLACK
            } else {
                // Compute the specular contribution
                let factor = pow(reflectDotEye, self.shininess)
                specular = light.intensity.multiplyScalar(self.specular * factor)
            }
        }

        return ambient.add(diffuse).add(specular)
    }
}

let DEFAULT_MATERIAL = Material(ColorStrategy.solidColor(Color(1, 1, 1)), 0.1, 0.9, 0.9, 200.0)
