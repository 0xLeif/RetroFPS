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
            
            let wallTexture: Bitmap
            let wallX: Double
            if end.x.rounded(.down) == end.x {
                wallTexture = textures[.wall]
                wallX = end.y - end.y.rounded(.down)
            } else {
                wallTexture = textures[.wall2]
                wallX = end.x - end.x.rounded(.down)
            }
            
            let textureX = Int(wallX * Double(wallTexture.width))
            let wallStart = Vector(x: Double(x), y: (Double(bitmap.height) - height) / 2 + 0.001)
            bitmap.drawColumn(textureX, of: wallTexture, at: wallStart, forHeight: height)
            
            
            columnPosition += step
        }
    }
}
