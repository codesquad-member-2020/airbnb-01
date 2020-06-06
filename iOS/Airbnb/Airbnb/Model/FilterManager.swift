//
//  FilterManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class FilterManager {
    
    static let shared = FilterManager()
    
    var currentLocation: String?
    var page: Int?
    var dateFilter: DateFilter?
    var guestInfo: GuestInfo?
    var priceFilter: PriceFilter?
    
    func queryString() -> String {
        var query = ""
        if let location = currentLocation {
            query = EndPoint.location + location
        }
        
        if let page = page {
            query += "&" + EndPoint.PageCount + "\(page)"
        }
        
        if let dateFilter = dateFilter {
            query += "&" + EndPoint.checkIn + "\(dateFilter.startDate.convertToString)" + "&" + EndPoint.checkOut + "\(dateFilter.endDate.convertToString)"
        }
        
        if let guestInfo = guestInfo {
            query += "&" + EndPoint.guest + guestInfo.totalGuest()
        }
        
        if let price = priceFilter {
            query += "&" + EndPoint.minPrice + price.min + "&" + EndPoint.maxPrice + price.max
        }
        
        return query
    }
}

struct DateFilter {
    var startDate: Date
    var endDate: Date
    var startIndexPath: IndexPath
    var endIndexPath: IndexPath
}

struct GuestInfo {
    var adult: String
    var youth: String
    var infants: String
    
    func totalGuest() -> String {
        return String(totalIntegerGuest())
    }
    
    func totalIntegerGuest() -> Int {
        guard let adultInteger = Int(adult), let youthInteger = Int(youth), let infantsInteger = Int(infants) else {return 0}
        return adultInteger + youthInteger + infantsInteger
    }
}

struct PriceFilter {
    var min: String
    var max: String
}
