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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setRadius() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setColor() {
        if isClicked {
            self.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    @objc func clicked(_ sender: UIButton) {
        isClicked = !isClicked
    }
}
