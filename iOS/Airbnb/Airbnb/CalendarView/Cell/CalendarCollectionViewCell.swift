//
//  CalendarCollectionViewCell.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.isHidden = false
        self.isUserInteractionEnabled = true
        leftView.backgroundColor = .clear
        rightView.backgroundColor = .clear
        deselected()
    }
    
    func selected() {
        dayLabel.textColor = .white
        dayLabel.backgroundColor = .black
        dayLabel.layer.cornerRadius = dayLabel.frame.height / 2
        dayLabel.layer.masksToBounds = true
    }
    
    func deselected() {
        dayLabel.textColor = .label
        dayLabel.backgroundColor = .clear
        dayLabel.layer.cornerRadius = 0
        dayLabel.layer.masksToBounds = false
    }

}
