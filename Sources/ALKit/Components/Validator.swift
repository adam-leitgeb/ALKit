//
//  Validator.swift
//  
//
//  Created by Adam Leitgeb on 10/05/2020.
//

import Foundation

public struct Validator<InputValue, OutputValue> {

    // MARK: - Properties

    public let validate: (InputValue) throws -> OutputValue

    // MARK: - Actions

    public func validate(_ inputValue: InputValue, combinedWith validators: Validator...) throws -> OutputValue {
        for validator in validators {
            _ = try validator.validate(inputValue)
        }
        return try validate(inputValue)
    }
}

// MARK: - Utilities for inline validation in forms

public extension Validator where InputValue == Optional<Any>, InputValue == Optional<OutputValue> {
    func validate(_ inputValue: InputValue, combineWith validators: Validator...) throws -> Optional<OutputValue> {
        guard let value = inputValue else {
            return inputValue
        }
        for validator in validators {
            _ = try validator.validate(value)
        }
        return try validate(value)
    }
}

public extension Validator where InputValue == Optional<String>, OutputValue == String {
    func validateAndSkipOptionals(_ inputValue: InputValue, combinedWith validators: Validator...) throws -> Optional<OutputValue> {
        guard let value = inputValue, !value.isEmpty else {
            return inputValue ?? ""
        }
        for validator in validators {
            _ = try validator.validate(value)
        }
        return try validate(value)
    }
}
