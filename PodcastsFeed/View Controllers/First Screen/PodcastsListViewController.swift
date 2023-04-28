//
//  ViewController.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import UIKit

class PodcastsListViewController: UITableViewController{
    var podcastLoader: PodcastLoaderViewController?
    private var imageLoader = URLSessionImageLoader()
    var arrayTable = [PodcastCellController](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.tableFooterView = self.loadMoreView()
                self.tableView.refreshControl = nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = podcastLoader?.view
        podcastLoader?.load()
        refreshControl?.beginRefreshing()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTable.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return cellController(forRowAt: indexPath).view(in: tableView)
        
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> PodcastCellController{
        arrayTable[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        arrayTable[indexPath.row].releaseCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "PodcastDetailViewController") as! PodcastDetailViewController
        detailsVC.imageLoader = imageLoader
        detailsVC.model = arrayTable[indexPath.row].model
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

}

extension PodcastsListViewController{
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrolledToBottom(scrollView) && Pagination.canLoadMore{
            podcastLoader?.load()
        }
    }
    private func scrolledToBottom(_ scrollView: UIScrollView) -> Bool{
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) && scrollView ==  tableView
        {
            return true
        }
        return false
    }
}


