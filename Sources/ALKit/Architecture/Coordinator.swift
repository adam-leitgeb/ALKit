//
//  Coordinator.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol Coordinator: class {
    associatedtype ViewController: UIViewController

    var viewController: ViewController? { get set }

    func configure(viewController: ViewController)
    func start()
    func stop()
}
