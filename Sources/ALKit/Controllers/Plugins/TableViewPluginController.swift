//
//  TableViewPluginController.swift
//
//
//  Created by Adam Leitgeb on 11/07/2019.
//

import DataSource
import UIKit

open class TableViewPluginController: UITableViewController, DataSourcablePlugin {

    // MARK: - Properties

    public weak var delegate: DataSourcablePluginDelegate?
    public var dataSource: DataSource
    public var footerView: UIView?

    // MARK: - Initialization

    public init(sections: [Section], style: UITableView.Style = .grouped) {
        dataSource = .init(sections: sections)
        super.init(style: style)
    }

    convenience public init(dataSource: DataSource, style: UITableView.Style = .grouped) {
        self.init(sections: [])
        self.dataSource = dataSource
    }

    convenience public init() {
        self.init(sections: [])
    }

    // State

    required public init?(coder aDecoder: NSCoder) {
        dataSource = aDecoder.decodeObject(forKey: "dataSource") as? DataSource ?? .init()
        super.init(coder: aDecoder)
    }

    override open func encode(with aCoder: NSCoder) {
        aCoder.encode(dataSource, forKey: "dataSource")
    }

    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        setupTableView()
    }

    // MARK: - Setup

    open func setupTableView() {
        dataSource.tableViewDelegate = self

        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 16.0, right: 0)
        tableView.estimatedRowHeight = 100.0
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    // MARK: - Utilities

    open func updateDataSource(with sections: [Section]) {
        dataSource.sections = sections
    }

    open func reload(with sections: [Section]) {
        dataSource.sections = sections
        tableView.reloadData()
    }

    open func pullToRefresh() {
        tableView.beginRefreshing()
    }

    open func updateContentInsets(_ insets: UIEdgeInsets) {
        tableView.contentInset = insets
    }

    open func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation) {
        tableView.reloadSections(indexSet, with: animation)
    }
}

// MARK: - Data source delegate

extension TableViewPluginController: TableViewDataSourceDelegate {
    open func tableViewWillScrollToBottom() {
        delegate?.willScrollToBottom()
    }
}
