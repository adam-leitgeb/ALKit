//
//  URL+Initialization.swift
//  
//
//  Created by Adam Leitgeb on 21/03/2020.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        guard let url = URL(string: string) else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        self = url
    }
}
