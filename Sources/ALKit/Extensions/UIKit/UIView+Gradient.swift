//
//  UIView+Gradient.swift
//
//
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

public extension UIView {
    /*
     When is gradient used in table / collection view, gradient layer has to be saved in local property,
     and it's frame has to be updated when layoutSubviews() is called:

     override func layoutSubviews() {
         super.layoutSubviews()

         gradient?.frame = bounds
     }
     */
    @discardableResult
    func addGradient(from fromAlpha: CGFloat, to toAlpha: CGFloat, _ color: UIColor) -> CAGradientLayer {
        let gradient = Self.gradient(from: fromAlpha, to: toAlpha, color, bounds: bounds)
        layer.insertSublayer(gradient, at: 0)

        return gradient
    }

    func cleanGradients() {
        layer.sublayers?
            .compactMap { $0 as? CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }
    }

    // Static methods

    static func gradient(from fromAlpha: CGFloat, to toAlpha: CGFloat, _ color: UIColor, bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            color.withAlphaComponent(fromAlpha).cgColor,
            color.withAlphaComponent(toAlpha).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.frame = bounds

        return gradient
    }
}
