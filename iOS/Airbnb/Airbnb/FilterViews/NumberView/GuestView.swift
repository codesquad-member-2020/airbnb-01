//
//  GuestView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class GuestView: UIView {
    
    private var number: Int = 0 {
        didSet {
            numberLabel.text = String(number)
            NotificationCenter.default.post(name: .NumberChanged,
                                            object: nil)
        }
    }
    
    override var description: String {
        return "\(number)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let name = String(describing: type(of: self))
        guard let loadedNib = Bundle.main.loadNibNamed(name, owner: self, options: nil) else { return }
        guard let view = loadedNib.first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setNumber(number: Int) {
        self.number = number
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
    
    func reset() {
        number = 0
    }

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var plusButton: BorderButton!
    @IBOutlet weak var minusButton: BorderButton!
    @IBAction func plusButtonClicked(_ sender: UIButton) {
        guard  number < 8 else {return}
        number += 1
    }
    @IBAction func minusButtonClicked(_ sender: UIButton) {
        guard  number > 0 else {return}
        number -= 1
    }
}

extension Notification.Name {
    static let NumberChanged = Notification.Name("NumberChanged")
}
