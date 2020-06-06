//
//  BookingButtonView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class BookingButtonView: UIView {
    
    @IBOutlet weak var bookingButton: BorderButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
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
    
    func setRating(rating: Double) {
        ratingLabel.text = String(rating)
    }
    
    func setDescriptionLabel(text: String) {
        descriptionView.text = text
    }
    
    @IBAction func bookingButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: .BookingButtonClicked,
                                        object: nil)
    }
}

extension Notification.Name {
    static let BookingButtonClicked = Notification.Name("BookingButtonClicked")
}
