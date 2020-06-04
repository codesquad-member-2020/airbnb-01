//
//  PriceViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController {

    @IBOutlet weak var filterContainerView: FilterContainerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterContainerView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
    }
}
