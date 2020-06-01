//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var filterView: FilterContainerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeButtonClicked),
                                               name: .CloseButtonClicked,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}
