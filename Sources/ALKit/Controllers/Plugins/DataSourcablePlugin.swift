//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 28/02/2020.
//

import DataSource
import UIKit

public protocol DataSourcablePluginDelegate: class {
    func willScrollToBottom()
}

public protocol DataSourcablePlugin: Plugin {
    var delegate: DataSourcablePluginDelegate? { get set }
    var footerView: UIView? { get set }

    func reload(with sections: [Section])
    func updateDataSource(with sections: [Section])
    func updateContentInsets(_ insets: UIEdgeInsets)
}
