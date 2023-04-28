//
//  PodcastDetailsViewTests.swift
//  PodcastDetailsViewTests
//
//  Created by Nav on 27/04/23.
//

import XCTest
@testable import PodcastsFeed

final class PodcastDetailsViewTests: XCTestCase {

    func test_viewDidLoad_displaysFavouritedTitleOnButton(){
        let podcast = makePodcast(title: "Some Podcast", description: "Some description", isFavourite: true)
        let sut = makeSUT(with: podcast)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.isFavourite, true)
        
    }
    
    func test_viewDidLoad_doesnotDisplayFavouritedTitleOnButton(){
        let podcast = makePodcast(title: "Some Podcast", description: "Some description", isFavourite: false)
        let sut = makeSUT(with: podcast)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.isFavourite, false)
        
    }
    
    
    func test_viewDidLoad_checksValuesOnLabel(){
        let podcast = makePodcast(title: "Some Podcast", description: "Some description", isFavourite: false)
        let sut = makeSUT(with: podcast)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.isFavourite, false)
        XCTAssertEqual(sut.titlePodcast, podcast.title)
        XCTAssertEqual(sut.descriptionPodcast, podcast.description)

        
    }
    
    
    func makeSUT(with model: Podcast) -> PodcastDetailViewController{
        let storyboard = UIStoryboard(name: "Podcast", bundle: Bundle(identifier: "com.heyhub.PodcastsFeed"))
                let sut = storyboard.instantiateViewController(identifier: "PodcastDetailViewController") as! PodcastDetailViewController
        sut.model = model

        return sut
        
    }
    
    func makePodcast(title: String, description: String, isFavourite: Bool = false) -> Podcast{
        let id = UUID().uuidString
        if isFavourite{
            UserDefaults.standard.set(true, forKey: id)
        }
           return Podcast(title: title, description: description, id: id, imageURL: anyURL(), thumbnailURL: anyURL(), publisher: "Some publisher")
        }
    
    
    private func anyURL() -> URL{
        URL(string: "http://any-podcast-url.com")!
    }

}

private extension PodcastDetailViewController{
    var isFavourite: Bool?{
        return buttonFavourite.currentTitle == "Favourited"
    }
    
    var titlePodcast: String?{
        return labelTitle.text
    }
    var author: String?{
        return labelAuthor.text
    }
    var descriptionPodcast: String?{
        return labelDescription.text
    }
}
