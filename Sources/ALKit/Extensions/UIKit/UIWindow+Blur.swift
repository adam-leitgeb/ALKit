//
//  UIWindow+Blur.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import UIKit

public extension UIWindow {
    func addBlur() {
        guard viewWithTag(blurEffectTag) == nil else {
            return
        }

        let blurEffect = UIBlurEffect(style: .dark)

        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.tag = blurEffectTag
        visualEffectView.frame = frame
        visualEffectView.alpha = 0

        addSubview(visualEffectView)

        UIView.animate(
            withDuration: 0.25,
            delay: 0.1,
            options: .curveEaseOut,
            animations:  {
                visualEffectView.alpha = 1
            },
            completion: nil
        )
    }

    func removeBlur() {
        guard let visualEffectView = viewWithTag(blurEffectTag) else {
            return
        }

        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
            animations: {
                visualEffectView.alpha = 0
            }, completion: { _ in
                visualEffectView.removeFromSuperview()
            }
        )
    }

    // Utilities

    private var blurEffectTag: Int {
        return 2_687
    }
}
