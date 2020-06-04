//
//  EndPoint.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

enum EndPoint {
    static let defaultURL = "http://13.125.127.249:8080/api/accommodations/"
    static let RoomList = "s/location?"
    static let pirce = "p/location?"
    static let location = "location="
    static let PageCount = "pageCount="
    static let checkIn = "checkIn="
    static let checkOut = "checkOut"
    static let guest = "guests="
    static let RoomDetail = "accommodations/"
    static let minPrice = "priceMin"
    static let maxPrice = "priceMax"
}
