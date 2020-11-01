//
//  WeatherAppNetworkTests.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/27/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import TopItuneSongs

class ItunesNetworkTests: XCTestCase {
    
    //MARK: Properties
    var itunesGateway: ItunesApiGateway?
    var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        itunesGateway = ItunesApiGateway(session: session)
    }
    
    //MARK: TestCases
    func testDataTaskResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        itunesGateway?.fetchSongs(url: url) { (songs) in
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testDataTaskUrlSet() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        
        itunesGateway?.fetchSongs(url: url) { (songs) in
        }
        XCTAssert((session.mockURL == url))
    }
}
