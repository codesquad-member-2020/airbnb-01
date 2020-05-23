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
    func loadResource(handler: @escaping (DataResult) -> ())
}

class NetworkManager: NetworkManageable {
    
    func loadResource(handler: @escaping (DataResult) -> ()) {
        AF.request(EndPoint.defaultURL + EndPoint.RoomList).validate(statusCode: 200..<300).response {
            handler($0.result)
        }
    }
}
