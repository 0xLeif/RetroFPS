//
//  World.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct World {
    public let map: Tilemap
    public var player: Player!
    
    public init(map: Tilemap) {
        self.map = map
        for y in 0 ..< map.height {
            for x in 0 ..< map.width {
                let position = Vector(x: x.to_d + 0.5, y: y.to_d + 0.5)
                let thing = map.things[y * map.width + x]
                switch thing {
                case .nothing:
                    break
                case .player:
                    self.player = Player(position: position)
                }
            }
        }
    }
}

public extension World {
    var size: Vector {
        map.size
    }
    
    mutating func update(delta: Double, input: Input) {
        let length = input.velocity.length
        if length > 0 {
            player.direction = input.velocity / length
        }
        player.velocity = input.velocity * player.speed
        player.position += player.velocity * delta
        while let intersection = player.intersection(with: map) {
            player.position -= intersection
        }
    }
}
