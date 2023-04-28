//
//  RemotePodcastClient.swift
//  PodcastFeed
//
//  Created by Nav on 26/04/23.
//

import Foundation
import PodcastAPI

public class RemotePodcastClient: PodcastClient{
    
    public func getPodcasts(completion: @escaping (PodcastClientResult) -> Void) {
        let apiKey = "58f6952f07d04062b5e2581ad61f134c"
        let client = PodcastAPI.Client(apiKey: apiKey)
        var parameters: [String: String] = [:]
        parameters["q"] = "star wars"
        parameters["offset"] = String(Pagination.offSet)
    

        client.search(parameters: parameters) { response in
            if let error = response.error {
                switch (error) {
                case PodcastApiError.apiConnectionError:
                    print("Can't connect to Listen API server")
                case PodcastApiError.authenticationError:
                    print("wrong api key")
                default:
                    print("unknown error")
                }
            } else {
                if let data = response.toJson() {
                    Pagination.offSet = data["next_offset"].intValue
                    completion(.success(data))
                }
                
            }
        }
    }
}
