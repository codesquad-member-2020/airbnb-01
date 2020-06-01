//
//  ImageUpdatable.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/01.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

protocol ImageUpdatable {
    var id: Int { get set }
    var images: [Image] {get set}
    
    func updatedIndices(url: String) -> [Int]
}

extension ImageUpdatable {
    func updatedIndices(url: String) -> [Int] {
        var indices = [Int]()
        for (index, image) in self.images.enumerated() {
            if image.url == url {
                indices.append(index)
            }
        }
        
        return indices
    }
}
