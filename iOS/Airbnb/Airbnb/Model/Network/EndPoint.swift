//
//  EndPoint.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

enum EndPoint {
    static let defaultURL = "http://13.125.127.249:8080/api/"
    static let RoomList = "accommodations/s/%7Blocation%7D?location=%EC%99%95%EC%8B%AD%EB%A6%AC&priceMax=70000&priceMin=50000"
}
