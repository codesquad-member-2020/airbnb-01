//
//  RoomListUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation
import Alamofire

struct RoomListUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func requestRoomList(failureHandler: @escaping (String) -> (), handler: @escaping ([Room]) -> ()) {
        networkManager.loadResource {
            switch $0 {
            case .success(let data):
                guard let data = data else {
                    failureHandler("no data")
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode([Room].self, from: data)
                    handler(model)
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
}
