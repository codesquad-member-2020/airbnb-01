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
    private var binder = [Int: [String: String?]]()
    
    private init() {}
    
    func registerRoomID(room: Room) {
        room.images.forEach {
            guard binder[room.id] != nil else {
                binder[room.id] = [String: String?]()
                binder[room.id]?.updateValue(nil, forKey: $0.url)
                return
            }
            binder[room.id]?.updateValue(nil, forKey: $0.url)
        }
    }
    
    func localUrl(of url: String) -> String? {
        
        return nil
    }
}
