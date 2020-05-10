//
//  Storyboarded.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol Storyboarded {
    associatedtype ViewController = UIViewController
}

// MARK: - Default implementation

public extension Storyboarded {

    // Properties

    private static var storyboardName: String {
        String(describing: self).replacingOccurrences(of: "ViewController", with: "")
    }

    private static var controllerId: String {
        String(describing: self) + "ID"
    }

    private static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: nil)
    }

    // Actions

    static func instantiateFromStoryboard<ViewController>() -> ViewController {
        if let viewController = storyboard.instantiateViewController(withIdentifier: controllerId) as? ViewController {
            return viewController
        } else {
            fatalError(
                """
                "Unable to instantiate view controller from storyboard!\n
                view controller: \(String(describing: self))\n
                storyboard name: \(storyboardName),\n
                storyboard id: \(controllerId)"
                """
            )
        }
    }
}

