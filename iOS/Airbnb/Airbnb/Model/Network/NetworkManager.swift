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
    func loadResource(method: HTTPMethod, headers: HTTPHeaders?, bodys: BookingBody? ,statusCode: Int, requestURL: String, handler: @escaping (DataResult) -> ())
    func downloadResource(urlPath: String, handler: @escaping (URLResult) -> ())
}

class NetworkManager: NetworkManageable {
    
    static var shared = NetworkManager()
    var token: String?
    
    func loadResource(method: HTTPMethod, headers: HTTPHeaders? = nil, bodys: BookingBody?, statusCode: Int, requestURL: String, handler: @escaping (DataResult) -> ()) {
        guard let urlPath = (requestURL).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            handler(.failure(.invalidURL(url: EndPoint.defaultURL + EndPoint.RoomList)))
            return
        }
        
        AF.request(urlPath, method: method, parameters: bodys, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: 200..<statusCode).response {
            handler($0.result)
        }
    }
    
    func downloadResource(urlPath: String, handler: @escaping (URLResult) -> ()) {
        AF.download(urlPath).validate(statusCode: 200..<300).response {
            handler($0.result)
        }
    }
}

struct Booking: Encodable {
    var accommodationId: Int
    var checkIn: String
    var checkOut: String
    var personCount: Int
}
