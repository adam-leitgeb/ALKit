//
//  LoadingButton.swift
//
//
//  Created by Adam Leitgeb on 22/07/2019.
//

import UIKit

/// Button with loading state & scale highlighting.
@IBDesignable
public final class LoadingButton: UIButton {

    // MARK: - Properties

    private var _title: String?
    private let activityView = UIActivityIndicatorView()

    // Button color

    public var enabledButtonBackgroundColor: UIColor? { backgroundColor }
    public var enabledTitleColor: UIColor? { titleColor(for: .normal) }

    public lazy var disabledButtonBackgroundColor: UIColor? = backgroundColor?.withAlphaComponent(0.7)
    public lazy var disabledTitleColor: UIColor? = titleColor(for: .normal)?.withAlphaComponent(0.7)

    // Activity indicator

    @IBInspectable public var activityIndicatorColor: UIColor = .white {
        didSet {
            activityView.color = activityIndicatorColor
        }
    }

    // MARK: - Initialization

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Setup

    private func setup() {
        _title = titleLabel?.text

        setupActivityView()
    }

    private func setupActivityView() {
        addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Actions

    public func startLoading() {
        setTitle(nil, for: .normal)
        isUserInteractionEnabled = false
        activityView.startAnimating()
    }

    public func stopLoading() {
        setTitle(_title, for: .normal)
        isUserInteractionEnabled = true
        activityView.stopAnimating()
    }

    // MARK: - Animations

    private func highlight() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }

    private func unhighlight() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

    // MARK: - UIButton

    override public var isHighlighted: Bool {
        didSet {
            super.isHighlighted = isHighlighted
            isHighlighted ? highlight() : unhighlight()
        }
    }

    override public var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled

            backgroundColor = isEnabled ? enabledButtonBackgroundColor : disabledButtonBackgroundColor
            setTitleColor(isEnabled ? enabledTitleColor : disabledTitleColor, for: .normal)
        }
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        if title != nil && title != "" {
            _title = title
        }
        super.setTitle(title, for: state)
    }
}
