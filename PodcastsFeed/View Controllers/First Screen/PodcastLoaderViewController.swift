//
//  PodcastLoaderViewController.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import Foundation
import UIKit
final class PodcastLoaderViewController: NSObject{
    private var podcastLoader: PodcastLoader?
    init(podcastLoader: PodcastLoader? = nil) {
        self.podcastLoader = podcastLoader
    }
    
     var view: UIRefreshControl = {
        let view = UIRefreshControl()
         view.addTarget(PodcastLoaderViewController.self, action: #selector(load), for: .valueChanged)
         return view
    }()
    
    var onLoad: (([Podcast]) -> Void)?
     func load(){
        view.beginRefreshing()
        podcastLoader?.load(completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.view.endRefreshing()
            }
            switch result{
            case let .success(arrayPodcasts):
                self?.onLoad?(arrayPodcasts)
            case .failure(_):
                break
            }
        })
    }
}
