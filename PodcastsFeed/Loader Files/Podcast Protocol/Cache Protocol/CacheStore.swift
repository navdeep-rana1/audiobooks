//
//  CacheStore.swift
//  PodcastsFeed
//
//  Created by Nav on 29/04/23.
//

import Foundation
enum CacheStoreResult{
    case success(Bool)
    case failure
}

protocol CacheStore{
    func checkForFavourite(_ id: String, completion: @escaping (CacheStoreResult) -> Void)
    func favouriteAction(_ id: String, completion: @escaping (CacheStoreResult) -> Void)
}
