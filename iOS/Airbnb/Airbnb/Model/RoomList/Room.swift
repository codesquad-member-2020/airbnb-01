//
//  Room.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct Room: Decodable, ImageUpdatable {
    var id: Int
    var images: [Image]
    var name: String
    var price: Price?
    var type: String
}

struct Image: Decodable {
    var type: String
    var url: String
}

struct Price: Decodable {
    var price: Int
}
