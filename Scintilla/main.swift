//
//  main.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

let world = chapterFourteenScene()

let from = point(0, 2, -5)
let to = point(0, 1, 0)
let up = vector(0, 1, 0)
let viewTransform = view(from, to, up)
let camera = Camera(800, 600, PI/3, viewTransform)

let canvas = camera.render(world)

let filePath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.appendingPathComponent("test.ppm")
try canvas.toPPM().write(to: filePath, atomically: true, encoding: .utf8)
