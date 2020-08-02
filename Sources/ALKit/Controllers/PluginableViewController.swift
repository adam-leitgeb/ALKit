//
//  PluginableViewController.swift
//  
//
//  Created by Adam Leitgeb on 26/02/2020.
//

import DataSource
import UIKit

public protocol PluginableViewControllerInput: class {
    func update(state: PluginableViewController.State)
    func updateDataSource(with sections: [Section])
    func addSpinnedInFooterView()
    func showHUD()
    func hideHUD()
}

open class PluginableViewController: UIViewController {

    // MARK: - Types

    public enum State {
        case isEmpty
        case isLoading
        case error(Error)
        case custom(Plugin)
        case populated(sections: [Section])
    }

    // MARK: - Properties

    public weak var currentlyPresentedHUD: UIViewController?
    public var isNextStateChangeAnimated: Bool = false

    open var currentPlugin: Plugin? {
        get {
            children.last as? Plugin
        }
        set {
            children.compactMap { $0 as? Plugin }.forEach { $0.remove() }
            newValue?.add(to: self, animated: isNextStateChangeAnimated)
            isNextStateChangeAnimated = false
        }
    }

    // MARK: - Actions

    open func reloadButtonTapped() {
        // Designated to be overriden.
    }

    open func pullToRefreshInitiated() {
        // Designated to be overriden.
    }

    // MARK: - Utilities

    public var tableViewPluginChildController: DataSourcablePlugin? {
        children.first(where: { $0 is DataSourcablePlugin }) as? DataSourcablePlugin
    }

    // Factories

    open var tableViewControllerPluginFactory: DataSourcablePlugin {
        TableViewPluginController(sections: [])
    }

    open var emptyStatePluginFactory: Plugin {
        EmptyStatePluginController()
    }

    open var errorStatePluginFactory: ErrorPlugin {
        ErrorStatePluginController()
    }

    open var loadingStatePluginFactory: Plugin {
        LoadingStatePluginController()
    }
}

// MARK: - DataSourcablePlugin delegate

extension PluginableViewController: DataSourcablePluginDelegate {
    open func willScrollToBottom() {
        // designated to override
    }
}

// MARK: - Default implementation

extension PluginableViewControllerInput where Self: PluginableViewController {
    public func update(state: PluginableViewController.State) {
        switch state {
        case .isEmpty:
            layoutEmptyState()
        case .isLoading:
            layoutLoadingState()
        case .error(let error):
            layoutError(error)
        case .custom(let plugin):
            currentPlugin = plugin
        case .populated(let sections):
            layoutPopulatedState(with: sections)
        }
    }

    public func updateDataSource(with sections: [Section]) {
        tableViewPluginChildController?.updateDataSource(with: sections)
    }

    public func addSpinnedInFooterView() {
        if tableViewPluginChildController == nil {
            update(state: .populated(sections: []))
        }

        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 44.0)
        spinner.startAnimating()

        var mutableTableViewPluginChildController = tableViewPluginChildController
        mutableTableViewPluginChildController?.footerView = spinner
    }

    public func showHUD() {
        guard currentlyPresentedHUD == nil else {
            return
        }
        let alert = UIAlertController.hud(customTitle: nil)
        currentlyPresentedHUD = alert
        present(alert, animated: true)
    }

    public func hideHUD() {
        currentlyPresentedHUD?.dismiss(animated: true) {
            self.currentlyPresentedHUD = nil
        }
    }

    // Utilities

    public func layoutLoadingState() {
        let plugin = loadingStatePluginFactory
        currentPlugin = plugin
        isNextStateChangeAnimated = true
    }

    public func layoutEmptyState() {
        let plugin = emptyStatePluginFactory
        currentPlugin = plugin
        isNextStateChangeAnimated = true
    }

    public func layoutError(_ error: Error) {
        var plugin = errorStatePluginFactory
        plugin.localizedDescription = error.localizedDescription
        currentPlugin = plugin
        isNextStateChangeAnimated = true
    }

    public func layoutPopulatedState(with sections: [Section]) {
        var plugin = isNextStateChangeAnimated
            ? tableViewControllerPluginFactory
            : tableViewPluginChildController ?? tableViewControllerPluginFactory

        if let current = currentPlugin, type(of: current) != type(of: plugin) {
            currentPlugin = plugin
        } else if currentPlugin == nil {
            currentPlugin = plugin
        } else if isNextStateChangeAnimated {
            currentPlugin = plugin
        }

        plugin.delegate = self
        plugin.reload(with: sections)
        plugin.footerView = UIView()

        if let tableViewController = plugin as? UITableViewController {
            tableViewController.refreshControl?.endRefreshing()
        } else if let collectionViewController = plugin as? UICollectionViewController {
            collectionViewController.collectionView.refreshControl?.endRefreshing()
        }
    }
}
