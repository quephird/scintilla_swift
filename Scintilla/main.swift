//
//  main.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

let world = chapterSevenScene()

let canvas = world.render()

canvas.save(to: "test.ppm")

