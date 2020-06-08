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
    static let accommodations = "accommodations/"
    static let RoomList = "s/location?"
    static let pirce = "p/location?"
    static let location = "location="
    static let PageCount = "pageCount="
    static let checkIn = "checkIn="
    static let checkOut = "checkOut="
    static let guest = "guests="
    static let minPrice = "priceMin="
    static let maxPrice = "priceMax="
    static let leftTopLongitude = "leftTopLongitude="
    static let leftTopLatitude = "leftTopLatitude="
    static let rightBottomLongitude = "rightBottomLongitude="
    static let rightBottomLatitude = "rightBottomLatitude="
    static let OAuth = "oauth/token"
    static let booking = "booking"
    static let coordinate = "s?"
}
