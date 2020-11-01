//
//  XMLParsingTest.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//


import XCTest
@testable import TopItuneSongs

class XMLParsingTest: XCTestCase {
    
    //MARK: setup methodes
    override func setUp() {
        super.setUp()
    }
    
    //MARK: TestCases
    func testXMLParing() throws {
        let testExpectation =  expectation(description: "fetch songs expectation")
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "validXml", withExtension: "xml") else {
            XCTFail("Missing file: validXml.xml")
            return
        }
        
        let parser = ItunesApiGateway(session:URLSession.shared)
        
        parser.fetchSongs(url:url) { (songs) in
            XCTAssertEqual(songs.count, 10)
            XCTAssertEqual(songs[0].artist, "BTS")
            XCTAssertEqual(songs[0].title, "Dynamite - Single")
            XCTAssertEqual(songs[0].updated, "2020-08-28T18:08:57-07:00")
            XCTAssertEqual(songs[0].imageUrl, "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/ad/5b/39/ad5b394f-1dbd-eacb-e9b0-a8fed8b9f16a/195497194223.jpg/170x170bb.png")
            XCTAssertEqual(songs[0].previewLink, "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview114/v4/02/00/5a/02005a7f-ae65-0c2c-a9e0-ba00627d6e6b/mzaf_5529373340235459142.plus.aac.p.m4a")
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
