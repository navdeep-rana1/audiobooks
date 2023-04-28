//
//  Pagination.swift
//  PodcastsFeed
//
//  Created by Nav on 28/04/23.
//

import Foundation

struct Pagination{
    static var canLoadMore: Bool{
        return offSet > 0
    }
    static var offSet = 0
}
