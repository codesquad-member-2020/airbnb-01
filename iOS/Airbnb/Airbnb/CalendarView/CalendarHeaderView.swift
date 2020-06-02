//
//  CalendarHeaderView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {
    
    var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    private func setLabel() {
        self.addSubview(monthLabel)
        monthLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        monthLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
