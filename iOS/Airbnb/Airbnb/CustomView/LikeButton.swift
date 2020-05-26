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
        self.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(scaleUp(_:)), for: .touchUpOutside)
        setColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(scaleUp(_:)), for: .touchUpOutside)
        setColor()
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
    
    private func scaleDown(_ sender: UIButton) {
        sender.scaleDown(sender)
    }
    
    @objc func scaleUp(_ sender: UIButton) {
        UIView.animateKeyframes(withDuration: 0.15, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    @objc func touchDown(_ sender: UIButton) {
        scaleDown(sender)
    }
    
    @objc func clicked(_ sender: UIButton) {
        isClicked = !isClicked
        scaleUp(sender)
    }
}

extension UIView {
    @objc func scaleDown(_ sender: UIView) {
        UIView.animateKeyframes(withDuration: 0.15, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            })
        })
    }
}
