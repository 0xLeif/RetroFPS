//
//  Renderer.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct Renderer {
    public private(set) var bitmap: Bitmap
    
    public init(width: Int, height: Int) {
        self.bitmap = Bitmap(width: width, height: height, color: .black)
    }
}

public extension Renderer {
    mutating func draw(_ world: World) {
        let scale = bitmap.height.to_d / world.size.y
        
        // Draw Map
        for y in 0 ..< world.map.height {
            for x in 0 ..< world.map.width where world.map[x, y].isWall {
                let rect = Rect(min: Vector(x: x.to_d, y: y.to_d) * scale,
                                max: Vector(x: (x + 1).to_d, y: (y + 1).to_d) * scale)
                bitmap.fill(frame: rect, color: .white)
            }
        }
        
        // Draw Player
        var frame = world.player.rect
        frame.max *= scale
        frame.min *= scale
        bitmap.fill(frame: frame, color: .blue)
    }
}
