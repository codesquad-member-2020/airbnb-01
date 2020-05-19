//
//  InsetTextField.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/19.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class PaddingTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0 {
        didSet {
            let insetView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
            self.leftView = insetView
            self.leftViewMode = .always
        }
    }
}
