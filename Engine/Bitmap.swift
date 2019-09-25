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
}
