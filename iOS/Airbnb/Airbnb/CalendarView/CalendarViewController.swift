//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private let weekDayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let calendarManager = CalendarManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterContainerView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
        
        setObserver()
        setWeekDayStackView()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeButtonClicked),
                                               name: .CloseButtonClicked,
                                               object: nil)
    }
    
    private func setWeekDayStackView() {
        filterContainerView.addSubviewInFilterView(view: weekDayStackView)
        weekDayStackView.topAnchor.constraint(equalTo: filterContainerView.filterView.topAnchor).isActive = true
        weekDayStackView.leadingAnchor.constraint(equalTo: filterContainerView.filterView.leadingAnchor).isActive = true
        weekDayStackView.trailingAnchor.constraint(equalTo: filterContainerView.filterView.trailingAnchor).isActive = true
        weekDayStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        for weekDay in CalendarManager.daysArr {
            let label = UILabel()
            label.text = weekDay
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            weekDayStackView.addArrangedSubview(label)
        }
    }
    
    @IBOutlet weak var filterContainerView: FilterContainerView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}
