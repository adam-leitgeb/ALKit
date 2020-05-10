//
//  UIImage+Videos.swift
//
//
//  Created by Adam Leitgeb on 01/10/2019.
//

import AVFoundation
import UIKit

public extension UIImage {
    static func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
        let asset = AVURLAsset(url: url)

        let assetIG = AVAssetImageGenerator(asset: asset)
        assetIG.appliesPreferredTrackTransform = true
        assetIG.apertureMode = .encodedPixels

        let cmTime = CMTime(seconds: time, preferredTimescale: 60)

        do {
            let thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
            return UIImage(cgImage: thumbnailImageRef)
        } catch let error {
            print(error)
            return nil
        }
    }
}
