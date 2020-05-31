//
//  ImageUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ImageUseCase {
    
    private var networkManager: NetworkManageable
    let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func enqueueImages(images: [Image], failureHandler: @escaping (String) -> (), completed: @escaping(String ,URL) -> ()) {
        images.forEach {
            let url = $0.url
            requestImage(imageURLPath: url, failureHandler: failureHandler, completed: {
                completed(url, $0)
            })
        }
    }
    
    func requestImage(imageURLPath: String, failureHandler: @escaping (String) -> (), completed: @escaping(URL) -> ()) {
        guard let lastComponet = URL(string: imageURLPath)?.lastPathComponent else {
            failureHandler("잘못된 url 입니다.")
            return
        }
        let imageURL = cachesDirectory.appendingPathComponent(lastComponet)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            completed(imageURL)
        } else {
            networkManager.downloadResource(urlPath: imageURLPath, handler: {
                switch $0 {
                case .failure(let error):
                    failureHandler(error.localizedDescription)
                case .success(let url):
                    guard let url = url else {
                        failureHandler("URL 응답이 없습니다.")
                        return
                    }
                    
                    try? FileManager.default.moveItem(at: url, to: imageURL)
                    completed(imageURL)
                }
            })
        }
    }
}
