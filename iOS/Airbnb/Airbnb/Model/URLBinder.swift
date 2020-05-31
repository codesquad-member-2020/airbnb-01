//
//  URLBinder.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class URLBinder {
    
    static let shared = URLBinder()
    private var binder = [Int: [String: String]]()
    
    private init() {}
}
