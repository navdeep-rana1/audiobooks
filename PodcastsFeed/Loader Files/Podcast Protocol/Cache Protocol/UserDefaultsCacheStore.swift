//
//  UserDefaultsCacheStore.swift
//  PodcastsFeed
//
//  Created by Nav on 29/04/23.
//

import Foundation
class UserDefaultsCacheStore: CacheStore{
    
    func checkForFavourite(_ id: String, completion: @escaping (CacheStoreResult) -> Void) {
        if UserDefaults.standard.bool(forKey: id) == true{
            completion(.success(true))
        }else{
            completion(.success(false))
        }
    }
    
    func favouriteAction(_ id: String, completion: @escaping (CacheStoreResult) -> Void) {
        
        if UserDefaults.standard.bool(forKey: id) == true{
            UserDefaults.standard.set(false, forKey: id)
            completion(.success(false))
                 }
        else{
            UserDefaults.standard.set(true, forKey: id)
            completion(.success(true))
        }
    }
    }
    
    

