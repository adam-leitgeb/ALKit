//
//  Collection+Utilities.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }
}
