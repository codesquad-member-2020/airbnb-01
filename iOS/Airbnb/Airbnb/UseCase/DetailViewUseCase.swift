//
//  DetailViewUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/26.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailViewUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func requestDetailView(roomId: Int, failureHandler: @escaping (String) -> (), successHandler: @escaping (RoomDetail) -> ()) {        
        networkManager.loadResource(method: .get, headers: nil, bodys: nil, statusCode: 300,  requestURL: EndPoint.defaultURL + EndPoint.accommodations + "\(roomId)") {
            switch $0 {
            case .success(let data):
                guard let data = data else {
                    failureHandler("no data")
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(RoomDetail.self, from: data)
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
}
