//
//  PriceUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class PriceUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func requestPrice(queryString: String, failureHandler: @escaping (String) -> (), successHandler: @escaping ([Int]) -> ()) {
        networkManager.loadResource(requestURL: EndPoint.defaultURL + EndPoint.pirce + queryString){
            switch $0 {
            case .success(let data):
                guard let data = data else {
                    failureHandler("no data")
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode([Int].self, from: data)
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
