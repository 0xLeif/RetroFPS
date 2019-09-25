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
        
        // Draw View Plane
        let focalLength = 1.0
        let viewWidth = 1.0
        let viewPlane = world.player.direction.orthogonal * viewWidth
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - viewPlane / 2
        let viewEnd = viewStart + viewPlane
        bitmap.drawLine(from: viewStart * scale, to: viewEnd * scale, color: .red)
        
        // Cast Rays
        let columns = 10
        let step = viewPlane / columns.to_d
        var columnPosition = viewStart
        for _ in 0 ..< columns {
            let rayDirection = columnPosition - world.player.position
            let viewPlaneDistance = rayDirection.length
            let ray = Ray(origin: world.player.position,
                          direction: rayDirection / viewPlaneDistance)
            let end = world.map.hitTest(ray)
            bitmap.drawLine(from: ray.origin * scale,
                            to: end * scale,
                            color: .green)
            columnPosition += step
        }
    }
}
