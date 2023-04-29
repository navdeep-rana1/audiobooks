//
//  PodcastCacheTests.swift
//  PodcastCacheTests
//
//  Created by Nav on 28/04/23.
//

import XCTest
@testable import PodcastsFeed




final class PodcastCacheTests: XCTestCase {

    
    func test_init_doesnotMessageStoreOnCreation(){
        let (_, store) = makeSUT()
        XCTAssertEqual(store.recievedCallCount, 0)
    }
    
    func test_isFavourite_callsStore(){
        let (sut, store) = makeSUT()
        let podcast = makePodcast(title: "iPhone 15 Podcast", description: "iPhone 15 Launch event")
        sut.isFavourite(podcastID: podcast.id){_ in}
        XCTAssertEqual(store.recievedCallCount, 1)
    }
    
    func test_isFavourite_returnsFalse(){
        let (sut, store) = makeSUT()
        let podcast = makePodcast(title: "iPhone 15 Podcast", description: "iPhone 15 Launch event")
        let exp = expectation(description: "Wait for store")
        sut.isFavourite(podcastID: podcast.id) { result in
            switch result{
            case true:
                XCTFail("Expected false")
            case false:
                break
            }
            exp.fulfill()
        }
        store.completefavouriteCheckWith(message: false)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_isFavourite_returnsTrue(){
        let (sut, store) = makeSUT()
        let podcast = makePodcast(title: "iPhone 15 Podcast", description: "iPhone 15 Launch event")
        let exp = expectation(description: "Wait for store")

        sut.isFavourite(podcastID: podcast.id) { result in
            switch result{
            case true:
                break
            case false:
                XCTFail("Expected true")
            }
            exp.fulfill()
        }
        store.completefavouriteCheckWith(message: true)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_addToFavourite_completesWithSuccessTrue(){
        let (sut, store) = makeSUT()
        let podcast = makePodcast(title: "iPhone 15 Podcast", description: "iPhone 15 Launch event")
        let exp = expectation(description: "Wait for store")
        exp.expectedFulfillmentCount = 2
        sut.isFavourite(podcastID: podcast.id) { result in
            switch result{
            case true:
                XCTFail("Expected false")

            case false:
                break
            }
            exp.fulfill()
        }
        store.completefavouriteCheckWith(message: false)
        
        sut.favouriteAction(podcastID: podcast.id) { result in
            switch result{
            case let .success(isSaved):
                XCTAssertTrue(isSaved)
            case .failure(_):
                XCTFail("Expected true")
            }
            exp.fulfill()
        }
        store.completeFavouriteAction(error: nil, message: true)
        XCTAssertEqual(store.receivedMessages, [CacheStoreMessages.checkForFavourite, .favouriteAction])
        wait(for: [exp], timeout: 1.0)
    }

    
    func test_addToFavourite_favouriteActionRemovesPodcastThatWasAlreadyFavourited(){
        let (sut, store) = makeSUT()
        let podcast = makePodcast(title: "iPhone 15 Podcast", description: "iPhone 15 Launch event")
        let exp = expectation(description: "Wait for store")
        exp.expectedFulfillmentCount = 2
        sut.isFavourite(podcastID: podcast.id) { result in
            switch result{
            case true:
                break
            case false:
                XCTFail("Expected true")
            }
            exp.fulfill()
        }
        store.completefavouriteCheckWith(message: true)
        
        sut.favouriteAction(podcastID: podcast.id) { result in
            switch result{
            case let .success(isSaved):
                XCTAssertFalse(isSaved)
            case .failure(_):
                XCTFail("Expected false")
            }
            exp.fulfill()
        }
        store.completeFavouriteAction(error: nil, message: false)
        XCTAssertEqual(store.receivedMessages, [CacheStoreMessages.checkForFavourite, .favouriteAction])
        wait(for: [exp], timeout: 1.0)
    }

    
    func makeSUT() -> (PodcastCache, CacheStoreSpy){
        let cacheStore = CacheStoreSpy()
        let sut = PodcastCache(cacheStore: cacheStore)
        return (sut, cacheStore)
    }
    func makePodcast(title: String, description: String, isFavourite: Bool = false) -> Podcast{
        let id = UUID().uuidString
        if isFavourite{
            UserDefaults.standard.set(true, forKey: id)
        }
           return Podcast(title: title, description: description, id: id, imageURL: anyURL(), thumbnailURL: anyURL(), publisher: "Some publisher")
        }

    private func anyError() -> NSError{
        NSError(domain: "Any podcast error", code: 10)
    }
    
    private func anyURL() -> URL{
        URL(string: "http://any-podcast-url.com")!
    }
    
    
    
    enum CacheStoreMessages{
        case checkForFavourite
        case favouriteAction
    }
    class CacheStoreSpy: CacheStore{
        var arrayCompletionCheckForFavourite = [(CacheStoreResult) -> Void]()
        var arrayCompletionFavouriteAction = [(CacheStoreResult) -> Void]()
        var recievedCallCount = 0
        var receivedMessages = [CacheStoreMessages]()
        
       
        func checkForFavourite(_ id: String, completion: @escaping (CacheStoreResult) -> Void)
        {
            recievedCallCount += 1
            receivedMessages.append(.checkForFavourite)
            arrayCompletionCheckForFavourite.append(completion)
        }
        
        func favouriteAction(_ id: String, completion: @escaping (CacheStoreResult) -> Void)
        {
            arrayCompletionFavouriteAction.append(completion)
            receivedMessages.append(.favouriteAction)
        }
        
        func completefavouriteCheckWith(message: Bool, at index: Int = 0){
            arrayCompletionCheckForFavourite[index](.success(message))
            
        }
        func completeFavouriteAction(error: Error?, message: Bool, at index: Int = 0){
            arrayCompletionFavouriteAction[index](.success(message))
        }
        
    }
}
