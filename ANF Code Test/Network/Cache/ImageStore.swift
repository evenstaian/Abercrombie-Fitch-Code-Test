//
//  ImageStore.swift
//  ANF Code Test
//
//  Created by Evens Taian on 28/01/25.
//

import Foundation
import UIKit

class ImageStore{

    typealias IsCached = Bool

    fileprivate let imageCache = NSCache<NSString, UIImage>()

    func fetch(for url:URL, completion: @escaping (UIImage?, IsCached) -> Void) {
        
        var secureURL = url
        if url.scheme == "http" {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.scheme = "https"
            if let httpsURL = components?.url {
                secureURL = httpsURL
            }
        }

        if let cachedImage = imageCache.object(forKey: secureURL.absoluteString as NSString) {

            completion(cachedImage, true)
            return
        }

        URLSession.shared.dataTask(with: secureURL) { (data, response, error) in

            if error != nil {

                print(error!)
                completion(nil, false)
                return
            }

            if let data = data {

                if let image = UIImage(data: data) {

                    self.imageCache.setObject(image, forKey: secureURL.absoluteString as NSString)
                    completion(image, false)
                    return
                }

                completion(nil, false)
            }
            
        }.resume()
    }

    func invalidate() {

        self.imageCache.removeAllObjects()
    }

    fileprivate func inject(image: UIImage, forKey key: String) {

        imageCache.setObject(image, forKey: key as NSString)
    }
}

