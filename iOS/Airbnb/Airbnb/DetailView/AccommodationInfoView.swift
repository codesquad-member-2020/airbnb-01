//
//  AccommodationInfoView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class AccommodationInfoView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var accommodationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var superHostStackView: UIStackView!
    @IBOutlet weak var addressLabel: UILabel!
    private let xibName = String(describing: AccommodationInfoView.self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    func setNameLabel(name: String) {
        accommodationLabel.text = name
    }
    
    func setRatingLabel(rating: Double) {
        ratingLabel.text = String(rating)
    }
    
    func setSuperHostStackView() {
        superHostStackView.isHidden = false
    }
    
    func setAddressLabel(address: String) {
        addressLabel.text = address
    }
    
    private func setXib() {
        let bundle = Bundle(for: AccommodationInfoView.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
