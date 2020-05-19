//
//  FirstViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class RoomListViewController: UIViewController {

    @IBOutlet var filterButtons: [FilterButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        
    }
    
    private func setButton() {
        filterButtons.forEach {
            $0.setRadius()
        }
    }
}

