//
//  CalendarCollectionViewCell.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.isHidden = false
    }
}
