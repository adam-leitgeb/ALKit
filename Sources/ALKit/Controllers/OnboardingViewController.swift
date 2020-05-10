//
//  TutorialPluginController.swift
//  FYMO
//
//  Created by Adam Leitgeb on 09/09/2019.
//  Copyright © 2019 Adam Leitgeb. All rights reserved.
//

import UIKit

public protocol OnboardingViewControllerDelegate: class {
    func pageDidChange(_ pageIndex: Int, outOf totalPageCount: Int)
}

open class OnboardingViewController: UIViewController {

    // MARK: - Properties

    public weak var delegate: OnboardingViewControllerDelegate?

    private var scrollView = UIScrollView()
    private var didLayoutOnce: Bool = false

    private var currentPage: Int = 0 {
        didSet {
            guard currentPage != oldValue else {
                return
            }
            delegate?.pageDidChange(currentPage, outOf: scrollView.subviews.count)
        }
    }

    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !didLayoutOnce {
            setupLayout()
            didLayoutOnce.toggle()
        }
        layoutScrollViewContent()
    }

    // MARK: - Setup

    private func setupLayout() {
        view.addSubviewWithConstraintsToEdges(viewToAdd: scrollView)
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
    }

    // MARK: - Layout

    private func layoutScrollViewContent() {
        scrollView.contentSize = CGSize(
            width: scrollView.frame.width * CGFloat(scrollView.subviews.count),
            height: 0.0
        )
        scrollView.subviews.enumerated().forEach { enumeratedView in
            enumeratedView.element.frame = CGRect(
                x: scrollView.frame.width * CGFloat(enumeratedView.offset),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
        }
    }

    // MARK: - Configuration

    public func reloadScrollView(with views: [UIView]) {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        views.forEach { scrollView.addSubview($0) }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    public func nextPage() {
        guard (currentPage + 1) < scrollView.subviews.count else {
            return
        }

        let nextPage = currentPage + 1
        let pageWidth: CGFloat = view.frame.width
        let targetContentOffset: CGFloat = pageWidth * CGFloat(nextPage)

        scrollView.setContentOffset(.init(x: targetContentOffset, y: 0.0), animated: true)
    }

    public func scrollToPage(_ pageNumber: Int) {
        currentPage = pageNumber

        let pageWidth: CGFloat = view.frame.width
        let targetContentOffset: CGFloat = pageWidth * CGFloat(currentPage)

        scrollView.setContentOffset(.init(x: targetContentOffset, y: 0.0), animated: true)
    }
}

// MARK: - Scroll view delegate

extension OnboardingViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / view.frame.width)
    }
}
