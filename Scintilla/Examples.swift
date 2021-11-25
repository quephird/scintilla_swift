//
//  Examples.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/24/21.
//

import Foundation

func chapterSevenScene() -> World {
    let floorTransform = scaling(10, 0.01, 10)
    let floorAndWallMaterial = Material(Color(1, 0.9, 0.9), 0.1, 0.9, 0.0, 200)
    let floor = Sphere(floorTransform, floorAndWallMaterial)

    let leftWallTransform = translation(0, 0, 5)
        .multiplyMatrix(rotationY(-PI/4))
        .multiplyMatrix(rotationX(PI/2))
        .multiplyMatrix(scaling(10, 0.01, 10))
    let leftWall = Sphere(leftWallTransform, floorAndWallMaterial)

    let rightWallTransform = translation(0, 0, 5)
        .multiplyMatrix(rotationY(PI/4))
        .multiplyMatrix(rotationX(PI/2))
        .multiplyMatrix(scaling(10, 0.01, 10))
    let rightWall = Sphere(rightWallTransform, floorAndWallMaterial)

    let leftBallTransform = translation(-1.5, 0.33, -0.75)
        .multiplyMatrix(scaling(0.33, 0.33, 0.33))
    let leftBallMaterial = Material(Color(1, 0.8, 0.1), 0.1, 0.7, 0.3, 200)
    let leftBall = Sphere(leftBallTransform, leftBallMaterial)


    let middleBallTransform = translation(-0.5, 1, 0.5)
    let middleBallMaterial = Material(Color(0.1, 1, 0.5), 0.1, 0.7, 0.3, 200)
    let middleBall = Sphere(middleBallTransform, middleBallMaterial)


    let rightBallTransform = translation(1.5, 0.5, -0.5)
        .multiplyMatrix(scaling(0.5, 0.5, 0.5))
    let rightBallMaterial = Material(Color(0.5, 1, 0.1), 0.1, 0.7, 0.3, 200)
    let rightBall = Sphere(rightBallTransform, rightBallMaterial)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, leftWall, rightWall, leftBall, middleBall, rightBall]

    return World(light, objects)
}

func chapterNineScene() -> World {
    let floorMaterial = Material(Color(1, 0.9, 0.9), 0.1, 0.9, 0.0, 200)
    let floor = Plane(IDENTITY4, floorMaterial)

    let leftBallTransform = translation(-1.5, 0.33, -0.75)
        .multiplyMatrix(scaling(0.33, 0.33, 0.33))
    let leftBallMaterial = Material(Color(1, 0.8, 0.1), 0.1, 0.7, 0.3, 200)
    let leftBall = Sphere(leftBallTransform, leftBallMaterial)


    let middleBallTransform = translation(-0.5, 1, 0.5)
    let middleBallMaterial = Material(Color(0.1, 1, 0.5), 0.1, 0.7, 0.3, 200)
    let middleBall = Sphere(middleBallTransform, middleBallMaterial)


    let rightBallTransform = translation(1.5, 0.5, -0.5)
        .multiplyMatrix(scaling(0.5, 0.5, 0.5))
    let rightBallMaterial = Material(Color(0.5, 1, 0.1), 0.1, 0.7, 0.3, 200)
    let rightBall = Sphere(rightBallTransform, rightBallMaterial)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, leftBall, middleBall, rightBall]

    return World(light, objects)
}
