//
//  DateFormatter+Initialization.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import Foundation

public extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
