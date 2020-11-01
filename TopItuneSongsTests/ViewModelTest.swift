//
//  ViewModelTest.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//


import XCTest
@testable import TopItuneSongs

class ViewModelTest : XCTestCase {
    
    //MARK: Properties
    var viewModel:SongsViewModel!
    let gateWay = MockedAPIGateway()
    
    //MARK: setup methodes
    override func setUp() {
        super.setUp()
       viewModel = SongsViewModel(parser: gateWay)
        
    }
    
    //MARK: TestCases
    func testFetchCalled() {
        viewModel.fetchData {
            XCTAssertTrue(self.gateWay.fetchCalled)
        }
    }
    
    func testNumberOfSongs() {
        viewModel.fetchData {
            XCTAssertEqual(self.viewModel.getNumberOfSongs(), 0)
        }
    }
}
