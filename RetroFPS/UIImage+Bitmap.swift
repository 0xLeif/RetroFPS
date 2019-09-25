//
//  UIImage+Bitmap.swift
//  RetroFPS
//
//  Created by Zach Eriksen on 9/25/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import UIKit
import Engine

extension UIImage {
    convenience init?(bitmap: Bitmap) {
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        let bytesPerPixel = MemoryLayout<Color>.size
        let bytesPerRow = bitmap.width * bytesPerPixel
        
        guard let providerRed = CGDataProvider(data: Data(bytes: bitmap.pixels, count: bitmap.height * bytesPerRow) as CFData) else {
            return nil
        }
        
        guard let image = CGImage(width: bitmap.width,
                                  height: bitmap.height,
                                  bitsPerComponent: 8,
                                  bitsPerPixel: bytesPerPixel * 8,
                                  bytesPerRow: bytesPerRow,
                                  space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: CGBitmapInfo(rawValue: alphaInfo.rawValue),
                                  provider: providerRed,
                                  decode: nil,
                                  shouldInterpolate: true,
                                  intent: .defaultIntent) else {
                                    return nil
        }
        
        self.init(cgImage: image)
    }
}
