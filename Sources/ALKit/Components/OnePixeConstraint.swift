//
//  OnePixeConstraint.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import UIKit

public class OnePixelConstraint: NSLayoutConstraint {

    // MARK: - Lifecycle

    override public func awakeFromNib() {
        super.awakeFromNib()

        constant = 1 / UIScreen.main.scale
    }
}
