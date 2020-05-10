//
//  String+Utilities.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import Foundation

public extension String {
    var isPhoneNumber: Bool {
        do {
            let checkingType: NSTextCheckingResult.CheckingType = .phoneNumber
            let detector = try NSDataDetector(types: checkingType.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, count))

            guard let result = matches.first else {
                return false
            }
            if result.resultType != .phoneNumber && result.range.location != 0 && result.range.length != self.count {
                return false
            }
            return true
        } catch {
            return false
        }
    }

    var isEmail: Bool {
        let argumentsList = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", argumentsList)

        return emailPredicate.evaluate(with: self)
    }
}
