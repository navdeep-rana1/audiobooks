//
//  PodcastCellController.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import Foundation
import UIKit

final class PodcastCellController{
    private var imageLoader: ImageLoader?
    var model: Podcast
    private var cell: PodcastCell?
    private var podcastCache: PodcastCache!
    init(imageLoader: ImageLoader, model: Podcast) {
        self.imageLoader = imageLoader
        self.model = model
        podcastCache = PodcastCache(cacheStore: UserDefaultsCacheStore())
    }
    
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "PodcastCell") as? PodcastCell
        cell?.labelTitle.text = model.title
        cell?.labelDescription.text = model.publisher
        
        podcastCache.isFavourite(podcastID: model.id) { [weak self] result in
            switch result{
            case true:
                self?.cell?.labelFavorite.isHidden = false
            case false:
                self?.cell?.labelFavorite.isHidden = true
            }
        }
        
        imageLoader?.loadImageData(from: model.thumbnailURL){ [weak self] result in
            switch result{
            case let .success(data):
                DispatchQueue.main.async {
                    self?.cell?.imageThumnail.image = UIImage(data: data)
                }
            case .failure(_):
                self?.cell?.imageThumnail.image = UIImage(named: "questionmark.app.fill")
            }
        }
        return cell!
    }
    
    func releaseCell(){
        cell = nil
    }
}
