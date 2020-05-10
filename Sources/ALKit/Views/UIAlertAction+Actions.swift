//
//  UIAlertAction+Actions.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import UIKit

public extension UIAlertAction {
    class var closeAction: UIAlertAction {
        closeAction({})
    }
}

public extension UIAlertAction {
    class func confirmAction(_ handler: @escaping TapHandler) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.confirm", comment: "Confirm"),
            style: .default,
            handler: { _ in handler() }
        )
    }

    class func retryAction(_ handler: @escaping TapHandler) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.retry", comment: "Retry"),
            style: .default,
            handler: { _ in handler() }
        )
    }

    class func openSettingsAction(_ handler: @escaping TapHandler) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.open-settings", comment: "Open settings"),
            style: .default,
            handler: { _ in handler() }
        )
    }

    class var openSettingsAction: UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.open-settings", comment: "Open settings"),
            style: .default,
            handler: { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        )
    }

    // Cancel

    class func closeAction(_ handler: TapHandler? = nil) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.close", comment: "Close"),
            style: .cancel,
            handler: { _ in handler?() }
        )
    }

    // Destructive

    class func removeAction(_ handler: @escaping () -> Void) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.remove", comment: "Remove"),
            style: .destructive,
            handler: { _ in handler() }
        )
    }

    class func logoutAction(_ handler: @escaping () -> Void) -> UIAlertAction {
        UIAlertAction(
            title: NSLocalizedString("alert.action.logout", comment: "Logout"),
            style: .destructive,
            handler: { _ in handler() }
        )
    }
}
