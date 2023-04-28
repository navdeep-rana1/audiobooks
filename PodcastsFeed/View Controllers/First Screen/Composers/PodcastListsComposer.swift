//
//  PodcastListsComposer.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import Foundation
import UIKit
public class PodcastListsComposer{
    
    static func composeWith(podcastLoader: PodcastLoader, imageLoader: ImageLoader) -> UINavigationController{
       let podcastLoader = PodcastLoaderViewController(podcastLoader: podcastLoader)
        let bundle = Bundle(identifier: "com.heyhub.PodcastsFeed")
        let storyBoard = UIStoryboard(name: "Podcast", bundle: bundle)
        
        let podcastController = storyBoard.instantiateInitialViewController() as! PodcastsListViewController
        podcastController.podcastLoader = podcastLoader
        podcastLoader.onLoad = transformPodcastsToCellControllers(for: podcastController, imageLoader: imageLoader)
        let navigationController = UINavigationController(rootViewController: podcastController)

        return navigationController
    }
    
    static func transformPodcastsToCellControllers(for podcastController: PodcastsListViewController, imageLoader: ImageLoader) -> ([Podcast]) -> Void {
        return { [weak podcastController] arrayPodcasts in
            podcastController?.arrayTable += arrayPodcasts.map{ podcast in
                PodcastCellController(imageLoader: imageLoader, model: podcast)
            }
        }
    }
}
