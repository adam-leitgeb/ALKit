//
//  NibableView.swift
//
//
//  Created by Adam Leitgeb on 18/01/2019.
//

import UIKit

open class NibableView: UIView {

    // MARK: Properties

    public var view: UIView!

    private var nibName: String {
        let `self` = type(of: self)
        return String(describing: self)
    }

    override public var backgroundColor: UIColor? {
        get {
            if let view = view {
                return view.backgroundColor
            } else {
                return super.backgroundColor
            }
        }
        set {
            if let view = view {
                view.backgroundColor = newValue
            } else {
                super.backgroundColor = newValue
            }
        }
    }

    // MARK: Init

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: Setup

    open func setup() {
        guard let bundle = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) else {
            fatalError("NibableView.xibSetup() - unable to load view from bundle")
        }

        view = bundle.first as? UIView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.frame = bounds

        addSubview(view)
    }
}
