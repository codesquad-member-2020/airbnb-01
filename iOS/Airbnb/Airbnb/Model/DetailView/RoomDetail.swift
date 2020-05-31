//
//  RoomDetail.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/26.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

struct RoomDetail: Decodable, HasImage {
    var coordinate: Coordinate
    var id: Int
    var images: [Image]
    var location: String
    var name: String
    var type: String
}

struct Coordinate: Decodable {
    var latitude: Double
    var longitude: Double
}
