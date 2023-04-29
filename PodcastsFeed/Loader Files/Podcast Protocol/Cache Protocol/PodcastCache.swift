//
//  PodcastCache.swift
//  PodcastsFeed
//
//  Created by Nav on 29/04/23.
//

import Foundation

public enum PodcastCacheResult{
    case success(Bool)
    case failure(Error)
}

class PodcastCache{
    
    private var cacheStore: CacheStore
    init(cacheStore: CacheStore) {
        self.cacheStore = cacheStore
    }
    
    func favouriteAction(podcastID: String, completion: @escaping (PodcastCacheResult) -> Void){
        cacheStore.favouriteAction(podcastID){ result in
            switch result{
            case let .success(isFav):
                completion(.success(isFav))
            case .failure:
                let error = NSError(domain: "Something unexpected happened", code: 10)
                completion(.failure(error))
            }
        }
    }
    
    func isFavourite(podcastID: String, completion: @escaping (Bool) -> Void){
        cacheStore.checkForFavourite(podcastID) { result in
            switch result{
            case let .success(isFav):
                completion(isFav)
            case .failure:
                completion(false)
            }
        }
    }
}
