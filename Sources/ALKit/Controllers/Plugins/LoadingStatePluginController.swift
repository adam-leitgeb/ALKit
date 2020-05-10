//
//  InitialLoadingPluginController.swift
//  FYMO
//
//  Created by Adam Leitgeb on 24/09/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

final public class LoadingStatePluginController: UIViewController, Plugin {

    // MARK: - Outlets

    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    private let stackView = UIStackView()

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

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.1) {
                self.stackView.alpha = 1.0
            }
        }
    }

    // MARK: - Setup

    private func setupViews() {
        titleLabel.textColor = .lightGray
        activityIndicator.startAnimating()
        stackView.alpha = 0.0
    }

    private func layoutViews() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(titleLabel)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Configuration

    public func configureStrings(title: String) {
        titleLabel.text = title
    }
}
