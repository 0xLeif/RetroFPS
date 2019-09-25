//
//  Bitmap.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct Bitmap {
    public private(set) var pixels: [Color]
    public let width: Int
}

public extension Bitmap {
    var height: Int {
        pixels.count / width
    }
    
    subscript(x: Int, y: Int) -> Color {
        get { pixels[y * width + x] }
        set {
            guard  (0 ..< width) ~= x,
                (0 ..< height) ~= y else {
                    return
            }
            pixels[y * width + x] = newValue
        }
    }
    
    init(width: Int, height: Int, color: Color) {
        self.pixels = Array(repeating: color, count: width * height)
        self.width = width
    }
    
    mutating func fill(frame: Rect, color: Color) {
        for y in frame.min.y.to_i ..< frame.max.y.to_i {
            for x in frame.min.x.to_i ..< frame.max.x.to_i {
                self[x, y] = color
            }
        }
    }
    
    mutating func drawLine(from: Vector, to: Vector, color: Color) {
        let difference = to - from
        let stepCount: Int
        let step: Vector
        if abs(difference.x) > abs(difference.y) {
            stepCount = abs(difference.x).rounded(.up).to_i
            let sign = difference.x > 0 ? 1.0 : -1.0
            step = Vector(x: 1, y: difference.y / difference.x) * sign
        } else {
            stepCount = abs(difference.y).rounded(.up).to_i
            let sign = difference.y > 0 ? 1.0 : -1.0
            step = Vector(x: difference.x / difference.y, y: 1) * sign
        }
        var point = from
        for _ in 0 ..< stepCount {
            self[point.x.to_i, point.y.to_i] = color
            point += step
        }
    }
}
