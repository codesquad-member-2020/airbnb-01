//
//  Room.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol HasImage {
    var id: Int { get set }
    var images: [Image] {get set}
}

struct Room: Decodable, HasImage {
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
