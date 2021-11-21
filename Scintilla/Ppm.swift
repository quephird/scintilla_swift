//
//  Ppm.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/20/21.
//

import Foundation

let MAX_PPM_LINE_WIDTH = 70

extension Canvas {
    func ppmHeader() -> String {
        "P3\n\(width) \(height)\n255"
    }

    func line(_ y: Int) -> String {
        var characterCount = 0
        var line = ""
        for x in 0...self.width-1 {
            let (r, g, b) = self.getPixel(x, y).toPpm()
            var temp = "\(r) \(g) \(b)"
            if characterCount + temp.count <= MAX_PPM_LINE_WIDTH {
                line.append(temp)
                characterCount += temp.count
            } else {
                var temp = "\(r) \(g)"
                if characterCount + temp.count <= MAX_PPM_LINE_WIDTH {
                    line.append(temp)
                    line.append("\n")
                    temp = "\(b)"
                    line.append(temp)
                    characterCount = temp.count
                } else {
                    temp = "\(r)"
                    if characterCount + temp.count <= MAX_PPM_LINE_WIDTH {
                        line.append(temp)
                        line.append("\n")
                        temp = "\(g) \(b)"
                        line.append(temp)
                        characterCount = temp.count
                    } else {
                        line.append("\n")
                        temp = "\(r) \(g) \(b)"
                        line.append(temp)
                        characterCount = temp.count
                    }
                }
            }

            if x != self.width-1 && characterCount < 69 {
                line.append(" ")
                characterCount += 1
            }
        }

        return line
    }

    func body() -> String {
        var body = ""
        for y in 0...self.height-1 {
            body.append(self.line(y))
            if y != self.height-1 {
                body.append("\n")
            }
        }

        return body
    }

    func toPPM() -> String {
        var ppm = ""
        ppm.append(self.ppmHeader())
        ppm.append("\n")
        ppm.append(self.body())
        return ppm
    }
}

extension Color {
    func clampAndScale(_ component: Double) -> Int {
        var c: Int
        if component < 0.0 {
            c = 0
        } else if component > 1.0 {
            c = 255
        } else {
            var cTemp = component*255
            cTemp.round()
            c = Int(cTemp)
        }
        return c
    }

    func toPpm() -> (Int, Int, Int) {
        (clampAndScale(self.r), clampAndScale(self.g), clampAndScale(self.b))
    }
}
