//
//  UrlSession+DataTaskExtension.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/24/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

//MARK: Urlsession extension and protocoles used for testing
protocol NetworkSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func sessionDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: NetworkSessionProtocol {
    func sessionDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
