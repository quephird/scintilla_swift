//
//  Traceable.swift
//  Scintilla
//
//  Created by Danielle Kefford on 11/22/21.
//

import Foundation

protocol Traceable {
    func intersect(_ ray: Ray) -> [Intersection]
}
