//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 29/02/2020.
//

import Foundation

final public class OnboardingPluginController: OnboardingViewController, Plugin {

    // MARK: - Initialization

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
