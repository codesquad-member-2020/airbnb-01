//
//  MapViewRoomList.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/07.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct MapViewRoomList: Decodable {
    var avgStar: Double
    var coordinate: Coordinate
    var guests: Int
    var id: Int
    var images: [Image]
    var location: String
    var name: String
    var price: Price
    var type: String
}
