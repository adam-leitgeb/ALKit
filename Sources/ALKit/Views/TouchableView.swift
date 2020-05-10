//
//  TouchableView.swift
//
//
//  Created by Adam Leitgeb on 13/08/2019.
//

import UIKit

open class TouchableView: NibableView {

    // MARK: - Properties

    var isHighlighted = false

    // MARK: - Setup

    override open func setup() {
        super.setup()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(action(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Actions

    @objc
    private func action(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .began:
            highlightAction()
        case .cancelled, .failed:
            unhighlightAction()
        case .ended:
            tapAction()
        case .changed, .possible:
            break
        @unknown default:
            break
        }
    }

    open func highlightAction() {
        isHighlighted = true
    }

    open func unhighlightAction() {
        isHighlighted = false
    }

    open func tapAction() {
    }
}
