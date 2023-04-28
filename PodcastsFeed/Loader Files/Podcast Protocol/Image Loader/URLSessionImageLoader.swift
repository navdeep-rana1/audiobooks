//
//  URLSessionImageLoader.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import Foundation
import UIKit
class URLSessionImageLoader: ImageLoader{
    let imageCache = NSCache<NSString, UIImage>()

    func loadImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage.pngData()!))
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                self.imageCache.setObject(UIImage(data: data!)!, forKey: url.absoluteString as NSString)

                completion(.success(data!))
            }.resume()
            
        }
    }
    
    
}
