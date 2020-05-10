//
//  Plugin.swift
//
//
//  Created by Adam Leitgeb on 11/07/2019.
//

import UIKit

public protocol Plugin {
    func add(to parent: UIViewController, animated: Bool)
    func add(to parent: UIViewController)
    func remove()
}

/// All plugin controllers has to conform to Plugin protocol
public extension Plugin where Self: UIViewController {
    func add(to parent: UIViewController, animated: Bool) {
        guard animated else {
            return add(to: parent)
        }

        view.alpha = 0.0
        add(to: parent)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.alpha = 1.0
        }, completion: nil)
    }

    func add(to parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(view)

        didMove(toParent: parent)
        view.frame = parent.view.bounds
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
