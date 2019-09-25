//
//  World.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct World {
    public let size: Vector
    public var player: Player
    
    public init() {
        size = Vector(x: 8, y: 8)
        player = Player(position: Vector(x: 4, y: 4))
    }
}

public extension World {
    mutating func update(delta: Double) {
        player.position += player.velocity * delta
        player.position.x.formTruncatingRemainder(dividingBy: 8)
        player.position.y.formTruncatingRemainder(dividingBy: 8)
    }
}
