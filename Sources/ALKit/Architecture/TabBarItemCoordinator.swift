//
//  TabBarItemCoordinator.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol TabBarItemCoordinator: Coordinator {
    typealias TabBarViewController = UITabBarController

    var navigationController: UINavigationController? { get set }
    var tabBarController: TabBarViewController? { get }
}

// MARK: - Default implementation

public extension TabBarItemCoordinator {

    // Actions

    func start() {
        let viewController: ViewController = .init()
        self.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController

        configure(viewController: viewController)

        var viewControllers = tabBarController?.viewControllers ?? []
        viewControllers.append(navigationController)

        tabBarController?.viewControllers = viewControllers
    }

    func stop() {
        _ = viewController
            .flatMap { $0.navigationController }
            .flatMap { tabBarController?.viewControllers?.firstIndex(of: $0) }
            .flatMap { tabBarController?.viewControllers?.remove(at: $0) }
    }
}


public extension TabBarItemCoordinator where ViewController: Storyboarded {

    // Actions
    
    func start() {
        let viewController: ViewController = .instantiateFromStoryboard()
        self.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController

        configure(viewController: viewController)

        var viewControllers = tabBarController?.viewControllers ?? []
        viewControllers.append(navigationController)

        tabBarController?.viewControllers = viewControllers
    }
}
