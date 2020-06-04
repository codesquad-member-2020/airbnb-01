//
//  RoomDetail.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/26.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

struct RoomDetail: Decodable, ImageUpdatable {
    var coordinate: Coordinate
    var id: Int
    var images: [Image]
    var location: String
    var name: String
    var type: String
    var reviews: [Review]
}

struct Coordinate: Decodable {
    var latitude: Double
    var longitude: Double
}

struct Review: Decodable {
    var star: Int
    var content: String
    var email: String
    var profileURL: String
    
    enum CodingKeys : String, CodingKey{
        case star
        case content
        case email = "authorEmail"
        case profileURL = "url"
    }
}
