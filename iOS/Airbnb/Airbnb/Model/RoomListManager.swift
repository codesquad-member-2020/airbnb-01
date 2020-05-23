//
//  RoomListManager.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct Manager<T> {
    
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
    
    private(set) var roomList: [T]
    
    func append(
    
}
