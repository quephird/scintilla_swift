//
//  Double.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/19/21.
//

import Foundation

let EPSILON = 0.00001

extension Double {
    func isAlmostEqual(_ to: Double) -> Bool {
        (self - to) < EPSILON
    }
}
