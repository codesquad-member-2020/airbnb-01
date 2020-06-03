//
//  GuestStackView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class GuestStackView: UIStackView {
    
    private let guestTitles = [["성인", "만13세 이상"],["청소년", "만3세 ~ 만12세"],["영유아", "만2세 이하"]]
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        axis = .vertical
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        
        guestTitles.forEach {
            let guestView = GuestView()
            
            guestView.setTitle(text: $0[0])
            guestView.setDescription(text: $0[1])
            
            addArrangedSubview(guestView)
        }
    }
    
    func reset() {
        self.subviews.forEach {
            guard let guestView = $0 as? GuestView else {return}
            guestView.reset()
        }
    }
    
    func isZero() -> Bool {
        for subView in subviews {
            if "\(subView)" != "0" {
                return false
            }
        }
        return true
    }
}
