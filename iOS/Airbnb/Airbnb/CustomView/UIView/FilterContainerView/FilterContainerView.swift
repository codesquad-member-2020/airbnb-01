//
//  FilterContainerView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class FilterContainerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: .CloseButtonClicked,
                                        object: nil)
    }
    
    private let xibName = String(describing: FilterContainerView.self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    private func setXib() {
        let bundle = Bundle(for: FilterContainerView.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension Notification.Name {
    static let CloseButtonClicked = Notification.Name("CloseButtonClicked")
}
