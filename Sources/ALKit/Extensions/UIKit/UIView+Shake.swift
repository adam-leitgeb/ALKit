//
//  UIView+Shake.swift
//
//
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

public extension UIView {
    func performShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 4.0, y: center.y)
        animation.fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 4.0, y: center.y)
        animation.toValue = NSValue(cgPoint: toPoint)

        layer.add(animation, forKey: "position")
    }
}
