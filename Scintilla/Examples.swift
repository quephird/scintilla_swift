//
//  Examples.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/24/21.
//

import Foundation

func chapterSevenScene() -> World {
    let floorTransform = scaling(10, 0.01, 10)
    let floorAndWallMaterial = Material(.solidColor(Color(1, 0.9, 0.9)), 0.1, 0.9, 0.0, 200, 0.0, 0.0, 0.0)
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
    let leftBallMaterial = Material(.solidColor(Color(1, 0.8, 0.1)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let leftBall = Sphere(leftBallTransform, leftBallMaterial)


    let middleBallTransform = translation(-0.5, 1, 0.5)
    let middleBallMaterial = Material(.solidColor(Color(0.1, 1, 0.5)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let middleBall = Sphere(middleBallTransform, middleBallMaterial)


    let rightBallTransform = translation(1.5, 0.5, -0.5)
        .multiplyMatrix(scaling(0.5, 0.5, 0.5))
    let rightBallMaterial = Material(.solidColor(Color(0.5, 1, 0.1)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let rightBall = Sphere(rightBallTransform, rightBallMaterial)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, leftWall, rightWall, leftBall, middleBall, rightBall]

    return World(light, objects)
}

func chapterNineScene() -> World {
    let floorMaterial = Material(.solidColor(Color(1, 0.9, 0.9)), 0.1, 0.9, 0.0, 200, 0.0, 0.0, 0.0)
    let floor = Plane(IDENTITY4, floorMaterial)

    let leftBallTransform = translation(-1.5, 0.33, -0.75)
        .multiplyMatrix(scaling(0.33, 0.33, 0.33))
    let leftBallMaterial = Material(.solidColor(Color(1, 0.8, 0.1)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let leftBall = Sphere(leftBallTransform, leftBallMaterial)


    let middleBallTransform = translation(-0.5, 1, 0.5)
    let middleBallMaterial = Material(.solidColor(Color(0.1, 1, 0.5)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let middleBall = Sphere(middleBallTransform, middleBallMaterial)


    let rightBallTransform = translation(1.5, 0.5, -0.5)
        .multiplyMatrix(scaling(0.5, 0.5, 0.5))
    let rightBallMaterial = Material(.solidColor(Color(0.5, 1, 0.1)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let rightBall = Sphere(rightBallTransform, rightBallMaterial)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, leftBall, middleBall, rightBall]

    return World(light, objects)
}

func chapterTenScene() -> World {
    let floorPattern = Checkered2D(BLACK, WHITE, rotationY(PI/6))
    let floorMaterial = Material(.pattern(floorPattern), 0.1, 0.9, 0.0, 200, 0.0, 0.0, 0.0)
    let floor = Plane(IDENTITY4, floorMaterial)

    let leftBallTransform = translation(-1.5, 0.33, -0.75)
        .multiplyMatrix(scaling(0.33, 0.33, 0.33))
    let leftBallMaterial = Material(.solidColor(Color(1, 0.8, 0.1)), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let leftBall = Sphere(leftBallTransform, leftBallMaterial)


    let middleBallTransform = translation(-0.5, 1, 0.5)
    let middleBallPattern = Checkered3D(
        Color(0.2, 0.6, 0.4),
        Color(0.8, 0.1, 0.4),
        scaling(0.25, 0.25, 0.25).multiplyMatrix(rotationY(PI/6)))
    let middleBallMaterial = Material(.pattern(middleBallPattern), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let middleBall = Sphere(middleBallTransform, middleBallMaterial)


    let gradientTransform = translation(-1, 0, 0).multiplyMatrix(scaling(2, 1, 1))
    let gradient = Gradient(Color(0.5, 1, 0.1), Color(0.9, 0.2, 0.4), gradientTransform)
    let rightBallTransform = translation(1.5, 0.5, -0.5)
        .multiplyMatrix(scaling(0.5, 0.5, 0.5))
    let rightBallMaterial = Material(.pattern(gradient), 0.1, 0.7, 0.3, 200, 0.0, 0.0, 0.0)
    let rightBall = Sphere(rightBallTransform, rightBallMaterial)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, leftBall, middleBall, rightBall]

    return World(light, objects)
}

func chapterThirteenScene() -> World {
    let floorPattern = Checkered2D(BLACK, WHITE, rotationY(PI/6))
    let floorMaterial = Material(.pattern(floorPattern), 0.1, 0.9, 0.0, 200, 0.0, 0.0, 0.0)
    let floor = Plane(IDENTITY4, floorMaterial)

    let shinyBlue = Material(.solidColor(Color(1.0, 0.3, 0.9)), 0.1, 0.9, 0.0, 200, 0.6, 0.0, 0.0)
    let cylinder = Cylinder(IDENTITY4, shinyBlue, 0, 2, true)

    let light = Light(point(-10, 10, -10), Color(1, 1, 1))
    let objects = [floor, cylinder]

    return World(light, objects)
}
