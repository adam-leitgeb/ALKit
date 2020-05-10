//
//  UIImage+Encoding.swift
//
//
//  Created by Adam Leitgeb on 09/08/2019.
//

import UIKit

public extension UIImage {
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "InputMessage")

        if let outputImage = filter?.outputImage?.transformed(by: .init(scaleX: 10.0, y: 10.0)) {
            return UIImage(ciImage: outputImage)
        }
        return nil
    }
}
