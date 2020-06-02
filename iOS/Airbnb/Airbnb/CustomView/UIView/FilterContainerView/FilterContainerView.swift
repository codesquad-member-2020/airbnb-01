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
    @IBOutlet weak var filterView: UIView!
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: .CloseButtonClicked,
                                        object: nil)
    }
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: .ResetButtonClicked,
                                        object: nil)
    }
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: .DoneButtonClicked,
                                        object: nil)
    }
    @IBOutlet weak var title: UILabel!
    
    func setTitle(text: String) {
        title.text = text
    }
    
    func addSubviewInFilterView(view: UIView) {
        filterView.addSubview(view)
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
    static let ResetButtonClicked = Notification.Name("ResetButtonClicked")
    static let DoneButtonClicked = Notification.Name("DoneButtonClicked")
}
