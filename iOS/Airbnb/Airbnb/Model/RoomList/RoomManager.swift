//
//  RoomListManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct RoomManager {
    
    enum EditingStyle {
        case insert(Room, IndexPath)
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
    
    private(set) var roomList: [Room]
    
    func room(of index: Int) -> Room {
        return roomList[index]
    }
    
    func index(findBy id: Int) -> Int? {
        for (index, room) in roomList.enumerated() {
            if room.id == id {
                return index
            }
        }
        return nil
    }
}
