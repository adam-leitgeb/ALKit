//
//  UIAlertController+Alerts.swift
//  
//
//  Created by Adam Leitgeb on 22/02/2020.
//

import UIKit

public extension UIAlertController {
    class var todoAlert: UIAlertController {
        let alert = UIAlertController(
            title: "TODO",
            message: "This feature isn't implemented yet.",
            preferredStyle: .alert
        )
        alert.addAction(.closeAction)

        return alert
    }

    class var cameraAccessDenied: UIAlertController {
        let alert = UIAlertController(
            title: NSLocalizedString("scan-bill.alert.camera-denied.title", bundle: .module, comment: "Access denied"),
            message: NSLocalizedString("scan-bill.alert.camera-denied.message", bundle: .module, comment: "Please, allow camera access in settings."),
            preferredStyle: .alert
        )
        alert.addAction(.openSettingsAction)
        alert.addAction(.closeAction)

        return alert
    }

    class func hud(customTitle: String? = nil) -> UIAlertController {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()

        let alert = UIAlertController(
            title: customTitle ?? NSLocalizedString("alert.hud.default-title", bundle: .module, comment: "Loading..."),
            message: nil,
            preferredStyle: .alert
        )
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 95).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20).isActive = true

        return alert
    }
}

