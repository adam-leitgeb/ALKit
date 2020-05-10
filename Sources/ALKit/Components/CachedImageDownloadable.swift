//
//  CachedImageDownloadable.swift
//  
//
//  Created by Adam Leitgeb on 31/12/2019.
//

import UIKit

/// Handles image download and caching logic. Typically used in `UITableViewCell` / `UICollectionViewCell`.
/// Don't forget to cancel all running downloads in `prepareForReuse()`!
public protocol CachedImageDownloadable: class {
    var imageCache: NSCache<NSString, UIImage> { get }
    var downloadImageTasks: [URLSessionDataTask] { get set }

    func downloadImage(with url: URL?, placeholder: UIImage?, completion: @escaping (UIImage?) -> Void)
    func cancelAllTasks()
}

public extension CachedImageDownloadable {
    func downloadImage(with url: URL?, placeholder: UIImage?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            return completion(placeholder)
        }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return DispatchQueue.main.async { completion(cachedImage) }
        }

        let task = URLSession.shared.dataTask(with: url) { data, urlRespose, error in
            guard
                let httpURLResponse = urlRespose as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = urlRespose?.mimeType, mimeType.hasPrefix("image")
            else {
                return DispatchQueue.main.async { completion(placeholder) }
            }

            if let data = data, let image = UIImage(data: data), error == nil {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async { completion(image) }
            } else if error != nil, data == nil {
                DispatchQueue.main.async { completion(placeholder) }
            }
        }
        downloadImageTasks.append(task)
        task.resume()
    }

    func cancelAllTasks() {
        downloadImageTasks.forEach { $0.cancel() }
        downloadImageTasks.removeAll()
    }
}
