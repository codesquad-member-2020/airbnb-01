//
//  LikeButton.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/19.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class LikeButton: UIButton {
    
    private var isClicked: Bool = false {
        didSet {
            setColor()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
        setColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setRadius() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setColor() {
        if isClicked {
            if #available(iOS 13, *) {
                self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                let image = UIImage(named: "heartFill")?.withRenderingMode(.alwaysTemplate)
                self.setImage(image, for: .normal)
                self.tintColor = .red
            }
        }else {
            if #available(iOS 13, *) {
                self.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
                self.setImage(image, for: .normal)
                self.tintColor = .red
            }
        }
    }
    
    @objc func clicked(_ sender: UIButton) {
        isClicked = !isClicked
    }
}
