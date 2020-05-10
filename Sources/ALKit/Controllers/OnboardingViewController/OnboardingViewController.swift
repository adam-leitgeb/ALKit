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

    // MARK: - Types

    private typealias Interval = (a: CGFloat, b: CGFloat)

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
            didLayoutOnce = true
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
        scrollView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        views.forEach { view in
            scrollView.addSubview(view)
        }

        view.setNeedsLayout()
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
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset

        let subviews: [UIView] = scrollView.subviews

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: 0.0)
        let intervals = makeIntervals(split: 1.0, by: subviews.count - 1)

        guard let interval = intervals.enumerated().first(where: { percentOffset.x > $0.element.a && percentOffset.x <= $0.element.b }) else {
            return
        }
        guard percentOffset.x > 0.0 && percentOffset.x <= 1, (interval.offset + 1) < subviews.count else {
            return
        }

        let scaleFactor = 1.0 / CGFloat(subviews.count - 1)
        let scale0 = (interval.element.b - percentOffset.x) / scaleFactor
        let scale1 = percentOffset.x / interval.element.b

        if let currentView = scrollView.subviews[safe: interval.offset] as? OnboardingViewScalable {
            currentView.scaleView(scale: scale0)
        }
        if let nextView = scrollView.subviews[safe: interval.offset + 1] as? OnboardingViewScalable {
            nextView.scaleView(scale: scale1)
        }

        currentPage = Int(scrollView.contentOffset.x / view.frame.width)
    }

    // MARK: - Utilities

    private func makeIntervals(split whole: CGFloat, by nPieces: Int) -> [Interval] {
        let step: CGFloat = whole / CGFloat(nPieces)
        let iterations: [CGFloat] = .init(repeating: step, count: nPieces)

        return iterations
            .enumerated()
            .map { Interval(a: $0.element * CGFloat($0.offset), b: $0.element * CGFloat($0.offset + 1)) }
    }
}
