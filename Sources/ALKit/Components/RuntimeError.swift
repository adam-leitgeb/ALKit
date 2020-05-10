//
//  RuntimeError.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import Foundation

public struct RuntimeError {
    let message: String

    public init(message: String) {
        self.message = message
    }
}

extension RuntimeError: LocalizedError {
    public var errorDescription: String? {
        message
    }
}

// MARK: - Common errors

extension RuntimeError {
    public static let blankError = RuntimeError(message: "")
}
