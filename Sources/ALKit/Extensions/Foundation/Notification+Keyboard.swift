//
//  Notification+Keyboard.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import UIKit

public extension Notification {
    var keyboardRect: CGRect? {
        guard let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        return keyboardSize.cgRectValue
    }
}
