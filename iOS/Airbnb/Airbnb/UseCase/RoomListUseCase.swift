//
//  RoomListUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct RoomListUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func requestRoomList(page: Int = 0, location: String, failureHandler: @escaping (String) -> (), successHandler: @escaping ([Room]) -> ()) {
        networkManager.loadResource(requestURL: EndPoint.defaultURL + EndPoint.RoomList + location + EndPoint.PageCount + "\(page)"){
            switch $0 {
            case .success(let data):
                guard let data = data else {
                    failureHandler("no data")
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode([Room].self, from: data)
                    successHandler(model)
                } catch {
                    failureHandler("Json decode error")
                }
                break
            case .failure(let error):
                failureHandler(error.localizedDescription)
                break
            }
        }
    }
    
    func requestMockRoomList(successHandler: @escaping ([Room]) -> ()) {
        let model = [Room](repeating: Room(id: 1, images: [Image(type: "hotel", url: "https://a0.muscache.com/im/pictures/cd6aa55e-1af7-450d-8975-bec51aa6b93e.jpg?im_w=1200"), Image(type: "hotel", url: "https://images.unsplash.com/photo-1466766655439-2c4b4f788ebf?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"), Image(type: "hotel", url: "https://images.unsplash.com/photo-1565443512485-4802529a006e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9")], name: "호텔호텔호텔", price: Price(price: 50000), type: "ㅁㄴㅇ"), count: 10)
        successHandler(model)
    }
}
