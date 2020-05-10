//
//  Keyboardable.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import UIKit

public protocol Keyboardable: ObservableDeinitialization {
    var keyboardObservers: [Any] { get set }

    func useKeyboard()
    func stopUsingKeyboard()
    func keyboardChanges(height: CGFloat)
}

// MARK: - Default implementations

public extension Keyboardable where Self: UIViewController {

    // Actions

    func useKeyboard() {
        let keyboardChangesBlock: (Notification) -> Void = { [weak self] notification in
            guard let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                return
            }
            let height = rect.cgRectValue.size.height

            if #available(iOS 11.0, *) {
                let bottomSafeAreaHeight = self?.view.safeAreaInsets.bottom ?? 0
                self?.keyboardChanges(height: height - bottomSafeAreaHeight)
            } else {
                self?.keyboardChanges(height: height)
            }
        }

        let keyboardWillHideBlock: (Notification) -> Void = { [weak self] _ in
            self?.keyboardChanges(height: 0.0)
        }

        keyboardObservers = [
            NotificationCenter.default
                .addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil, using: keyboardChangesBlock),
            NotificationCenter.default
                .addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: keyboardWillHideBlock)
        ]

        onDeinit {
            self.stopUsingKeyboard()
        }
    }

    func stopUsingKeyboard() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
    }
}
