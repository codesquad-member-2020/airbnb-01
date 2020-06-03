//
//  FilterLabel.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/19.
//  Copyright © 2020 신한섭. All rights reserved.
//
import UIKit

@IBDesignable class FilterButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    private var isClicked: Bool = false {
        didSet {
            setColor()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setRadius() {
        self.layer.cornerRadius = self.frame.height / 2.5
    }
    
    func setColor() {
        if isClicked {
            if #available(iOS 13, *) {
                self.layer.borderColor = UIColor.link.cgColor
                self.setTitleColor(.link, for: .normal)
            } else {
                self.layer.borderColor = UIColor(named: "link")?.cgColor
                self.setTitleColor(UIColor(named: "link"), for: .normal)
            }
        } else {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.setTitleColor(.lightGray, for: .normal)
        }
        
    }

    func deselected() {
        isClicked = false
    }
    
    func selected() {
        isClicked = true
    }
}
