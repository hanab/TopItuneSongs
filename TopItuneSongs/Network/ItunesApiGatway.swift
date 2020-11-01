//
//  ItunesApiGatway.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/24/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//
import Foundation

protocol GateWayProtocol {
    func fetchSongs(url: URL, completionHandler: (([Song]) -> Void)?)
}

class ItunesApiGateway: NSObject, GateWayProtocol {
    
    //MARK: Properties
    private let session: NetworkSessionProtocol
    private var songs =  [Song]()
    private var currentElement = ""
    
    //MARK: Properties for parsing
    private var updated:String = ""
    private var id: String = ""
    private var title: String = ""
    private var artist: String = ""
    private var link: String = ""
    private var imageUrl: String = ""
    private var price: String = ""
    
    private var parserCompletionHandler: (([Song]) -> Void)?
    
    //MARK: Init
    init(session: NetworkSessionProtocol) {
        self.session = session
    }
    
    //MARK: Methods
    func fetchSongs(url: URL, completionHandler: (([Song]) -> Void)?) {
        let request = URLRequest(url: url)
        self.parserCompletionHandler = completionHandler
        
        let task = session.sessionDataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        })
        task.resume()
    }
    
    private func resetFields(){
        updated = ""
        id = ""
        title = ""
        artist = ""
        imageUrl = ""
        price = ""
    }
}

// MARK: - XML Parser Delegate
extension ItunesApiGateway: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        switch currentElement {
        case "entry": resetFields()
        case "im:image": imageUrl = ""
        case "im:name": title = ""
        case "link" :
            if attributeDict.keys.contains("title"){
                if let prevLink = attributeDict["href"] {
                    link = prevLink
                }
            }
        default: break
        }
    }
       
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        switch currentElement {
        case "updated": updated += string
        case "id" : id += string
        case "im:name" : title += string
        case "im:artist" : artist += string
        case "im:image": imageUrl += string
        case "im:price" : price += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "entry" {
            let song = Song(updated: updated, id: id, title: title, artist: artist, previewLink: link, imageUrl: imageUrl, price:price)
            self.songs.append(song)
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(songs)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
