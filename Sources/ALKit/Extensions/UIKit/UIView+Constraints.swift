//
//  UIView+Constraints.swift
//  
//
//  Created by Adam Leitgeb on 02/03/2020.
//

import UIKit

extension UIView {
    public func addSubviewWithConstraintsToEdges(viewToAdd view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
