//
//  PersonNameComponents+Utilities.swift
//
//
//  Created by Adam Leitgeb on 21/07/2019.
//

import AuthenticationServices
import Foundation

extension PersonNameComponents {
    public var formatted: String? {
        guard let givenName = givenName, let familyName = familyName else {
            return nil
        }
        return "\(givenName) \(familyName)"
    }
}
