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
    private let textures: Textures
    
    public init(width: Int, height: Int, textures: Textures) {
        self.bitmap = Bitmap(width: width, height: height, color: .black)
        self.textures = textures
    }
}

public extension Renderer {
    mutating func draw(_ world: World) {
        let focalLength = 1.0
        let viewWidth = bitmap.width.to_d / bitmap.height.to_d
        let viewPlane = world.player.direction.orthogonal * viewWidth
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - viewPlane / 2
        
        // Cast Rays
        let columns = bitmap.width
        let step = viewPlane / columns.to_d
        var columnPosition = viewStart
        for x in 0 ..< columns {
            let rayDirection = columnPosition - world.player.position
            let viewPlaneDistance = rayDirection.length
            let ray = Ray(origin: world.player.position,
                          direction: rayDirection / viewPlaneDistance)
            let end = world.map.hitTest(ray)
            let wallDistance = (end - ray.origin).length
            let wallHeight = 1.0
            let distanceRatio = viewPlaneDistance / focalLength
            let perpendicular = wallDistance / distanceRatio
            let height = wallHeight * focalLength / perpendicular * bitmap.height.to_d
            
            let wallColor: Color
            if end.x.rounded(.down) == end.x {
                wallColor = .white
            } else {
                wallColor = .gray
            }
            
            bitmap.drawLine(from: Vector(x: x.to_d, y: (bitmap.height.to_d - height) / 2),
                            to: Vector(x: x.to_d, y: (bitmap.height.to_d + height) / 2),
                            color: wallColor)
            
            columnPosition += step
        }
    }
}
