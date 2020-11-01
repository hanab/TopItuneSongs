//
//  MockedViewModel.swift
//  TopItuneSongsTests
//
//  Created by Hana  Demas on 8/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import TopItuneSongs

class MockedAPIGateway:  GateWayProtocol {
    
    //MARK: Properties
    var fetchCalled = false
    
    //MARK: TestCases
    func fetchSongs(url: URL, completionHandler: (([Song]) -> Void)?) {
        fetchCalled = true
        completionHandler!([Song]())
    }
}
