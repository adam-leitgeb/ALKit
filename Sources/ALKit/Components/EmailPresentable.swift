//
//  EmailPresentable.swift
//  
//
//  Created by Adam Leitgeb on 19/02/2020.
//

import Foundation
import MessageUI

public protocol EmailPresentable: MFMailComposeViewControllerDelegate {
    func displayEmail(recipient: String, subject: String, body: String)
}

// MARK: - Default implementation

public extension EmailPresentable where Self: Coordinator {
    func displayEmail(recipient: String, subject: String, body: String) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }

        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self

        mailController.setToRecipients([recipient])
        mailController.setSubject(subject)
        mailController.setMessageBody(body, isHTML: false)

        viewController?.present(mailController, animated: true, completion: nil)
    }
}

public extension EmailPresentable where Self: NSObject {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
