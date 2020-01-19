//
//  Texture.swift
//  RetroFPS
//
//  Created by Zach Eriksen on 10/6/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public enum Texture: String, CaseIterable {
    case wall, wall2
}

public struct Textures {
    private let textures: [Texture: Bitmap]
}

public extension Textures {
    init(loader: (String) -> Bitmap) {
        var textures = [Texture: Bitmap]()
        for texture in Texture.allCases {
            textures[texture] = loader(texture.rawValue)
        }
        self.init(textures: textures)
    }
    
    subscript(_ texture: Texture) -> Bitmap {
        return textures[texture]!
    }
}
