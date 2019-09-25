//
//  Player.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct Player {
    public let speed: Double = 2
    public let radius: Double = 0.25
    public var position: Vector
    public var velocity: Vector
    
    public init(position: Vector) {
        self.position = position
        self.velocity = Vector(x: 0, y: 0)
    }
}

public extension Player {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
    
    func intersection(with map: Tilemap) -> Vector? {
        let minX = rect.min.x.to_i
        let maxX = rect.max.x.to_i
        let minY = rect.min.y.to_i
        let maxY = rect.max.y.to_i
        var largestIntersection: Vector?
        for y in minY ... maxY {
            for x in minX ... maxX where map[x, y].isWall {
                let wallRect = Rect(
                    min: Vector(x: Double(x), y: Double(y)),
                    max: Vector(x: Double(x + 1), y: Double(y + 1))
                )
                if let intersection = rect.intersection(with: wallRect),
                    intersection.length > largestIntersection?.length ?? 0 {
                    largestIntersection = intersection
                }
            }
        }
        return largestIntersection
    }
}
