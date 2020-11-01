//
//  SongsViewModel.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/26/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

class SongsViewModel {
    
    //MARK: Properties
    fileprivate var songs = [Song]()
    var parser:GateWayProtocol?
    
    //MARK: init
    init(parser: GateWayProtocol = ItunesApiGateway(session: URLSession.shared)) {
        self.parser = parser
    }
    
      //MARK: Methods
    func fetchData(completion: (() -> ())?) { 
        self.parser?.fetchSongs(url: ItunesAPI.itunesTopSongsUrl(limit: 200)) { [weak self] (songs) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.songs = songs
            completion?()
        }
    }
    
    //MARK: functions to prepare data for UITablview
    func getNumberOfSongs() -> Int {
        return self.songs.count
    }
    
    func getSongAtIndex(index:Int) -> Song? {
        guard index < self.songs.count else {
            return nil
        }
        return self.songs[index]
    }
}
