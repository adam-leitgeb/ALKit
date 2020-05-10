//
//  EmptyStatePluginController.swift
//  FYMO
//
//  Created by Adam Leitgeb on 02/10/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

final public class EmptyStatePluginController: UIViewController, Plugin {

    // MARK: - Outlets

    private let titleLabel = UILabel()

    // MARK: - Properties

    private var didLayoutOnce = false

    // MARK: - Initialization

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !didLayoutOnce {
            layoutViews()
            didLayoutOnce = true
        }
    }

    // MARK: - Setup

    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 26.0, weight: .bold)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layoutViews() {
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Configuration

    public func configureStrings(title: String) {
        titleLabel.text = title
    }
}
