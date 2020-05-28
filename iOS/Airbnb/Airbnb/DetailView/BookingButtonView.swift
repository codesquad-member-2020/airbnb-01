//
//  BookingButtonView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class BookingButtonView: UIView {
    
    @IBOutlet var contentView: UIView!
    private let xibName = String(describing: BookingButtonView.self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    private func setXib() {
        let bundle = Bundle(for: BookingButtonView.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
