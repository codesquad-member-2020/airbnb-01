//
//  FilterManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class FilterManager {
    
    var dateFilter: DateFilter?
    var guestInfo: GuestInfo?
}

struct DateFilter {
    var startDate: Date
    var endDate: Date
}

struct GuestInfo {
    var adult: String
    var youth: String
    var infants: String
}
