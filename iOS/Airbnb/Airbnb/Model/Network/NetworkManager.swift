//
//  NetworkManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManageable {
    typealias DataResult = Result<Data?, AFError>
    typealias URLResult = Result<URL?, AFError>
    func loadResource(requestURL: String, handler: @escaping (DataResult) -> ())
    func downloadResource(urlPath: String, handler: @escaping (URLResult) -> ())
}

class NetworkManager: NetworkManageable {
    
    static var shared = NetworkManager()
    var token: String?

    func loadResource(requestURL: String, handler: @escaping (DataResult) -> ()) {
        guard let url = (requestURL).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            handler(.failure(.invalidURL(url: EndPoint.defaultURL + EndPoint.RoomList)))
            return
        }
        
        AF.request(url).validate(statusCode: 200..<300).response {
            handler($0.result)
        }
    }
    
    func downloadResource(urlPath: String, handler: @escaping (URLResult) -> ()) {
        AF.download(urlPath).validate(statusCode: 200..<300).response {
            handler($0.result)
        }
    }
}
