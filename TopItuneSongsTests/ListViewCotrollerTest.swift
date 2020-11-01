//
//  ListViewCotrollerTest.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//


import XCTest
@testable import TopItuneSongs

class ListViewControllerTest: XCTestCase {
    
    //MARK:Properies
    var listViewController:ListViewController?
    
    //MARK:setup methodes
    override func setUp() {
        super.setUp()
        
        listViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "list") as? ListViewController
       listViewController?.loadView()
    }
    
    //MARK: TestCases
    func testTableViewExists() {
        XCTAssertNotNil(listViewController?.songsTableView)
    }
    
    func testRefreshCotrolExists() {
       XCTAssertNotNil(listViewController?.refreshControl)
    }
    
    func testNavigationTitleSet(){
        listViewController?.viewDidLoad()
        XCTAssertEqual(listViewController?.navigationItem.title, "Top Songs")
    }
}
