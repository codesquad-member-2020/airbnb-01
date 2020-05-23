//
//  RoomListManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol ModelManageble {
    associatedtype model
}

struct Manager<T>: ModelManageble {
    
    typealias model = T
    
    enum EditingStyle {
        case insert(T, IndexPath)
        case none
    }
    
    var editingStyle: EditingStyle {
        didSet {
            switch editingStyle {
            case let .insert(new, indexPath):
                roomList.insert(new, at: indexPath.row)
            default:
                break
            }
        }
    }
    
    var count: Int {
        get {
            return roomList.count
        }
    }
    
    private(set) var roomList: [T]
}
