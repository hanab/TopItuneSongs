//
//  ItunesAPI.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/25/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

class ItunesAPI {
    
    //MARK: Properies
    fileprivate static let baseURLString = "https://itunes.apple.com/us/rss/topsongs/"
    
    //MARK: Methods
    static func itunesTopSongsUrl(limit: Int) -> URL {
        let stringUrl = baseURLString + "limit=\(limit)/xml"
        return URL(string: stringUrl)!
    }
}
