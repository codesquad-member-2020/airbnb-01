//
//  GraphView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    private var rangeSlider = RangeSlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rangeSlider)
        print(frame)
        rangeSlider.frame = frame
    }
    
    override func layoutSubviews() {
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
