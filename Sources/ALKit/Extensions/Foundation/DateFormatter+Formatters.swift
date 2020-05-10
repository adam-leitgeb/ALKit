//
//  DateFormatter+Formatters.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import Foundation

public extension DateFormatter {
    static let long = DateFormatter(dateFormat: "dd MMMM yyyy")
    static let medium = DateFormatter(dateFormat: "d. M. yyyy")
    static let short = DateFormatter(dateFormat: "d. M.")
}
