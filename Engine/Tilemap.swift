//
//  Tilemap.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct Tilemap: Decodable {
    private let tiles: [Tile]
    public let things: [Thing]
    public let width: Int
}

public extension Tilemap {
    var height: Int {
        tiles.count / width
    }
    
    var size: Vector {
        Vector(x: width.to_d, y: height.to_d)
    }
    
    subscript(x: Int, y: Int) -> Tile {
        tiles[y * width + x]
    }
}
