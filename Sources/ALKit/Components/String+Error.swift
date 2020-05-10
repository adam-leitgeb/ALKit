//
//  String+Error.swift
//  
//
//  Created by Adam Leitgeb on 10/05/2020.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? {
        self
    }
}
