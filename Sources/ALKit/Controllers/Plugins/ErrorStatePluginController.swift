//
//  ErrorStatePluginViewController.swift
//  FYMO
//
//  Created by Adam Leitgeb on 08/08/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

final public class ErrorStatePluginController: UIViewController, ErrorPlugin {

    // MARK: - Outlets

    private var titleLabel = UILabel()
    private var messageLabel = UILabel()
    private var actionButton = LoadingButton()

    // MARK: - Properties

    private let textStackView = UIStackView()
    private let masterStackview = UIStackView()
    private var didLayoutOnce = false

    public var titleTextColor: UIColor = .black
    public var messageTextColor: UIColor = .lightGray
    public var isAutomaticLoadingEnabled: Bool = true
    public var actionHandler: TapHandler?

    public var localizedDescription: String? {
        didSet {
            messageLabel.text = localizedDescription
        }
    }

    // MARK: - Initialization

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        setupStackViews()
        setupInitialLayout()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        displayAnimated()
    }

    // MARK: - Setup

    private func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 20.0)
        titleLabel.textColor = titleTextColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        messageLabel.font = .systemFont(ofSize: 17.0)
        messageLabel.textColor = messageTextColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
    }

    private func setupStackViews() {
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.spacing = 8.0
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(messageLabel)

        masterStackview.axis = .vertical
        masterStackview.alignment = .fill
        masterStackview.distribution = .fill
        masterStackview.spacing = 16.0
        masterStackview.translatesAutoresizingMaskIntoConstraints = false
        masterStackview.addArrangedSubview(textStackView)
        masterStackview.addArrangedSubview(actionButton)
    }

    private func setupInitialLayout() {
        masterStackview.alpha = 0.0
        masterStackview.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        view.addSubview(masterStackview)
        NSLayoutConstraint.activate([
            masterStackview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0),
            masterStackview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 32.0),
            masterStackview.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Configuration

    public func configureStrings(title: String, actionTitle: String, buttonColor: UIColor = .systemGray) {
        titleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.backgroundColor = buttonColor
    }

    // MARK: - Actions

    @IBAction private func actionButtonTapped(_ sender: LoadingButton) {
        if isAutomaticLoadingEnabled {
            sender.startLoading()
        }
        actionHandler?()
    }

    // MARK: - Utilities

    public func stopLoading() {
        actionButton.stopLoading()
    }

    private func displayAnimated() {
        UIView.animate(withDuration: 0.2) {
            self.masterStackview.alpha = 1.0
            self.masterStackview.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}