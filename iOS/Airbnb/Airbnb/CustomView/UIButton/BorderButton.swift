//
//  BorderButton.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/27.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setBorderWidth()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            setBorderColor()
        }
    }
    
    @IBInspectable var corderRadius: CGFloat = 0 {
        didSet {
            setCornerRadius()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setBorderWidth() {
        self.layer.borderWidth = borderWidth
    }
    
    func setBorderColor() {
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setCornerRadius() {
        self.layer.cornerRadius = corderRadius
    }
}
