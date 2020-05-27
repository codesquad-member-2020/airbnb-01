//
//  RoomListViewModel.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Model
}

class RoomListViewModel: ViewModelBinding {

    typealias Model = Room
    typealias ModelManager = Manager<Model>
    private(set) var roomListManager: ModelManager {
        didSet {
            handler(roomListManager)
        }
    }
    
    let handler: (ModelManager) -> ()
    
    init(roomListManager: ModelManager, handler: @escaping (ModelManager) -> () = {_ in}) {
        self.roomListManager = roomListManager
        self.handler = handler
        handler(roomListManager)
    }
    
    func appendRoom(room: Model) {
        roomListManager.editingStyle = .insert(room, IndexPath(row: roomListManager.count, section: 0))
    }
}
