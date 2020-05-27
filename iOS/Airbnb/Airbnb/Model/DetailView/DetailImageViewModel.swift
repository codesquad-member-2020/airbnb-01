//
//  DetailImageViewModel.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/26.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class DetailImageViewModel: ViewModelBinding {
    
    typealias Model = [UIImage]?
    
    private var images : Model = nil {
        didSet {
            changedHandler(images)
        }
    }
    private var changedHandler : (Model)->()
    
    init(with images: [UIImage], changed handler: @escaping (Model) -> () = { _ in }) {
        self.changedHandler = handler
        self.images = images
        changedHandler(images)
    }
    
    func append(image: UIImage) {
        self.images?.append(image)
    }
    
    func updateNotify(changed: @escaping (Model) -> ()) {
        self.changedHandler = changed
    }
}
