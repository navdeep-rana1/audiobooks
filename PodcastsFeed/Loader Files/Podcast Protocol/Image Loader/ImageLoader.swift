//
//  ImageLoader.swift
//  PodcastsFeed
//
//  Created by Nav on 28/04/23.
//

import Foundation

public protocol ImageLoader{
        func loadImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
