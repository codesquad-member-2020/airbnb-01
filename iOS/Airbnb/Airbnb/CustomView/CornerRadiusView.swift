//
//  CornerRadiusView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/19.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class CornerRadiusView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

}
