//
//  UnwrapOptional.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import Foundation

public func unwrap<T>(_ object: T?) throws -> T {
    guard let object = object else {
        throw RuntimeError(message: "Object is nil")
    }
    return object
}
