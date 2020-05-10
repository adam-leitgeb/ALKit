//
//  ModalCoordinator.swift
//  ALKit
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol ModalCoordinator: Coordinator {
    var sourceController: UIViewController? { get }
    var navigationController: UINavigationController? { get set }
    var animated: Bool { get }
}

// MARK: - Default implementation

public extension ModalCoordinator {

    // Properties

    var animated: Bool {
        true
    }

    // Actions

    func stop() {
        viewController?.dismiss(animated: animated, completion: nil)
    }

    func start() {
        let viewController: ViewController = .init()
        self.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController

        configure(viewController: viewController)
        sourceController?.present(navigationController, animated: animated, completion: nil)
    }
}

public extension ModalCoordinator where ViewController: Storyboarded {

    // Actions

    func start() {
        let viewController: ViewController = .instantiateFromStoryboard()
        self.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController

        configure(viewController: viewController)
        sourceController?.present(navigationController, animated: animated, completion: nil)
    }
}
