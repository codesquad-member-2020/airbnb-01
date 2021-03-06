//
//  Date.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

extension Date {
    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var convertToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var year: Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        
        return year
    }
    
    var month: Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        
        return month
    }
    
    var day: Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        
        return day
    }
}
