//
//  SongTest.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import TopItuneSongs

class SongTests : XCTestCase {
    
    //MARK: TestCases
    func testSongInitalizer() {
        let song = Song(updated:"8/28/2020", id: "1", title: "Dynamite", artist: "BTS", previewLink: "http://preview/dynamite", imageUrl: "http://imagurl/dynamite", price: "$1.2")
        
        XCTAssertEqual(song.artist, "BTS")
        XCTAssertEqual(song.title, "Dynamite")
        XCTAssertEqual(song.price, "$1.2")
        XCTAssertEqual(song.previewLink, "http://preview/dynamite")
        XCTAssertEqual(song.imageUrl, "http://imagurl/dynamite")
        XCTAssertEqual(song.id, "1")
    }
}
