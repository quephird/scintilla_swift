//
//  main.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

let world = testScene()

let canvas = world.render()

canvas.save(to: "test.ppm")
