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
    
    func requestRoomList(failureHandler: @escaping (String) -> (), successHandler: @escaping ([Room]) -> ()) {
        networkManager.loadResource {
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
        let model = [Room](repeating: Room(id: 1, images: [Image(type: "hotel", url: "https://a0.muscache.com/im/pictures/cd6aa55e-1af7-450d-8975-bec51aa6b93e.jpg?im_w=1200"), Image(type: "hotel", url: "https://a0.muscache.com/im/pictures/cd6aa55e-1af7-450d-8975-bec51aa6b93e.jpg?im_w=1200"), Image(type: "hotel", url: "https://a0.muscache.com/im/pictures/cd6aa55e-1af7-450d-8975-bec51aa6b93e.jpg?im_w=1200")], name: "호텔호텔호텔", price: Price(price: 50000), type: "ㅁㄴㅇ"), count: 10)
        successHandler(model)
    }
}
