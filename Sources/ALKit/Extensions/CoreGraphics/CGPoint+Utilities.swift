//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import CoreGraphics

public extension CGPoint {
    func isWithin(_ frame: CGRect) -> Bool {
        frame.minX...frame.maxX ~= x && frame.minY...frame.maxY ~= y
    }
}
