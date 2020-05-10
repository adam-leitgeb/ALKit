//
//  PushCoordinator.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol PushCoordinator: Coordinator {
    var navigationController: UINavigationController? { get }
    var animated: Bool { get }
}

// MARK: - Default implementation

public extension PushCoordinator {

    // Properties

    var animated: Bool {
        true
    }

    // Actions

    func start() {
        let viewController: ViewController = .init()
        self.viewController = viewController

        configure(viewController: viewController)
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func stop() {
        navigationController?.popViewController(animated: animated)
    }
}

public extension PushCoordinator where ViewController: Storyboarded {

    // Actions
    
    func start() {
        let viewController: ViewController = .instantiateFromStoryboard()
        self.viewController = viewController

        configure(viewController: viewController)
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
