//
//  CalendarManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class CalendarManager {
    static let daysArr = ["일", "월", "화", "수", "목", "금", "토"]
    private var months: [MonthInfo]
    private var currentYear = Calendar.current.component(.year, from: Date())
    private var currentMonth = Calendar.current.component(.month, from: Date())

    init() {
        months = [MonthInfo]()
        addYearInfo()
    }

    func addYearInfo() {
        for _ in 0...12 {
            let startOfMonth = weekDay(year: currentYear, month: currentMonth)
            let totalDay = Calendar.current.component(.day, from: "\(currentYear)-\(currentMonth)-01".convertDate().endOfMonth)

            let monthInfo = MonthInfo(month: currentMonth, startOfMonth: startOfMonth, totalDays: totalDay, year: currentYear)
            months.append(monthInfo)
            
            if currentMonth + 1 > 12 {
                currentMonth = 1
                currentYear += 1
            } else {
                currentMonth += 1
            }
        }
    }
    
    func monthInfo(of section: Int) -> MonthInfo {
        return months[section]
    }
    
    private func weekDay(year: Int, month: Int) -> Int {
        return Calendar.current.component(.weekday, from: "\(year)-\(month)-01".convertDate())
    }
}

struct MonthInfo {
    let month: Int
    let startOfMonth: Int
    let totalDays: Int
    let year: Int
}
