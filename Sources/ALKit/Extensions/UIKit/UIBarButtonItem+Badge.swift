//
//  UIBarButtonItem+Badge.swift
//
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import UIKit

private var handle: UInt8 = 0

public extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }

    func setBadge(text: String?, offset: CGPoint = .zero, color: UIColor = .red, filled: Bool = true, fontSize: CGFloat = 11.0) {
        badgeLayer?.removeFromSuperlayer()

        guard let text = text, !text.isEmpty else {
            return
        }
        addBadge(text: text, offset: offset, color: color, filled: filled)
    }

    private func addBadge(text: String, offset: CGPoint = .zero, color: UIColor = .red, filled: Bool = true, fontSize: CGFloat = 11) {
        guard let view = self.value(forKey: "view") as? UIView else {
            return
        }

        var font = UIFont.systemFont(ofSize: fontSize)

        if #available(iOS 9.0, *) {
            font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .regular)
        }

        let badgeSize = text.size(withAttributes: [.font: font])

        // initialize Badge
        let badge = CAShapeLayer()

        let height = badgeSize.height + 2 // padding
        var width = badgeSize.width + 4 // padding

        // make sure we have at least a circle
        if width < height {
            width = height
        }

        // x position is offset from right-hand side
        let x = view.frame.width - width + offset.x

        let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y - 2), size: CGSize(width: width, height: height))

        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)

        // initialiaze Badge's label
        let label = LCTextLayer()
        label.string = text
        label.alignmentMode = .center
        label.font = font
        label.fontSize = font.pointSize

        label.frame = badgeFrame
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)

        // save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        // bring layer to front
        badge.zPosition = 1_000
    }

    private func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }

}

// MARK: - Utilities

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

class LCTextLayer: CATextLayer {

    // REF: http://lists.apple.com/archives/quartz-dev/2008/Aug/msg00016.html
    // CREDIT: David Hoerl - https://github.com/dhoerl
    // USAGE: To fix the vertical alignment issue that currently exists within the CATextLayer class. Change made to the yDiff calculation.

    override func draw(in context: CGContext) {
        let height = bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height - fontSize) / 2 - fontSize / 10

        context.saveGState()
        context.translateBy(x: 0, y: yDiff) // Use -yDiff when in non-flipped coordinates (like macOS's default)

        super.draw(in: context)

        context.restoreGState()
    }
}
