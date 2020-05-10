//
//  UIView+IB.swift
//
//
//  Created by Adam Leitgeb on 18/01/2019.
//

import UIKit

public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var fullyRoundedCorners: Bool {
        get {
            layer.cornerRadius == min(frame.width, frame.height) / 2
        }
        set {
            guard newValue else {
                return
            }
            layer.cornerRadius = min(frame.width, frame.height) / 2
            layer.masksToBounds = true
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
