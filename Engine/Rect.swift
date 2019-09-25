//
//  Rect.swift
//  Engine
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import Foundation

public struct Rect {
    var min, max: Vector
    
    public init(min: Vector, max: Vector) {
        self.min = min
        self.max = max
    }
}
