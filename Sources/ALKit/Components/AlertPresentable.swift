//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import UIKit

public protocol AlertPresentable: class {
    func displayAlert(with error: Error)
    func stop()
}

// MARK: - Default implementation

public extension Coordinator {
    func displayAlert(with error: Error) {
        let alert: UIAlertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(.closeAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
