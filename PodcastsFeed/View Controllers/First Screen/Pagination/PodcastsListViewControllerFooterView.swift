//
//  PodcastsListViewControllerFooterView.swift
//  PodcastsFeed
//
//  Created by Nav on 28/04/23.
//

import Foundation
import UIKit
extension PodcastsListViewController{
    func loadMoreView() -> UIView {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: (self.view.frame.width), height: 30)))
        let labelLoadMore = UILabel(frame: view.frame)
        var stringLabel = "End of results"
        if Pagination.canLoadMore{
            stringLabel = "Pull to load more"
        }
        labelLoadMore.text = stringLabel
        labelLoadMore.textAlignment = .center
        view.addSubview(labelLoadMore)
        return view
    }
}
