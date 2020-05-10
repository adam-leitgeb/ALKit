//
//  UIImage+TabBar.swift
//
//
//  Created by Adam Leitgeb on 21/08/2019.
//

import UIKit

public extension UIImage {
    func tabBarImageWithCustomTint(tintColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        guard let context: CGContext = UIGraphicsGetCurrentContext(), let blendMode = CGBlendMode(rawValue: 1), let cgImage = cgImage else {
            return nil
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(blendMode)

        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        tintColor.setFill()
        context.fill(rect)

        var newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        newImage = newImage?.withRenderingMode(.alwaysOriginal)
        return newImage
    }
}
