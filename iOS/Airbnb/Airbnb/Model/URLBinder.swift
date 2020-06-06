//
//  URLBinder.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class URLBinder {
    
    static let shared = URLBinder()
    private var binder = [Int: [String: URL?]]()
    
    private init() {}
    
    func registerRoomID(room: ImageUpdatable) {
        room.images.forEach {
            guard binder[room.id]?[$0.url] == nil else {return}
            guard binder[room.id] != nil else {
                binder[room.id] = [String: URL?]()
                binder[room.id]?.updateValue(nil, forKey: $0.url)
                return
            }
            binder[room.id]?.updateValue(nil, forKey: $0.url)
        }
    }
    
    func localUrl(index: Int, of url: String) -> URL? {
        let dic = binder[index]
        guard let result = dic?[url] else {return URL(fileURLWithPath: "")}
        return result
    }
    
    func updateURL(roomID: Int, serverURL: String, localURL: URL) {
        binder[roomID]?.updateValue(localURL, forKey: serverURL)
        NotificationCenter.default.post(name: .URLBinded,
                                        object: nil,
                                        userInfo: ["roomID" : roomID, "serverURL" : serverURL])
    }
}

extension Notification.Name {
    static let URLBinded = Notification.Name("URLBinded")
}
