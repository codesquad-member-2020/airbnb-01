//
//  BookingUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct BookingUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func booking(roomId: Int, failureHandler: @escaping (String) -> (), successHandler: @escaping (String) -> ()) {
        guard let token = NetworkManager.shared.token else {return}
//        let token = "ㅋㅋ"
        guard let date = FilterManager.shared.dateFilter else {return}
        guard let guest = FilterManager.shared.guestInfo else {return}
        let body = BookingBody(accommodationId: roomId, checkIn: date.startDate.convertToString, checkOut: date.endDate.convertToString, personCount: guest.totalIntegerGuest())
        
        networkManager.loadResource(method: .post, headers: ["Authorization" : token], bodys: body, statusCode: 500, requestURL: EndPoint.defaultURL + EndPoint.booking, handler: {
            switch $0 {
            case .success(_):
                successHandler("예약 성공!!")
                break
            case .failure(let error):
                if error.responseCode == 500 {
                    failureHandler("이미 선택된 숙소입니다!")
                }
                failureHandler(error.localizedDescription)
                break
            }
        })
    }
}

struct BookingBody: Codable {
    var accommodationId: Int
    var checkIn: String
    var checkOut: String
    var personCount: Int
}
