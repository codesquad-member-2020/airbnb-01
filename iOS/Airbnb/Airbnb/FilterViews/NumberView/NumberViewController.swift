//
//  NumberViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {
    
    private var guestStackView = GuestStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterContainerView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
        
        setObserver()
        setTitle()
        setGuestStackView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var filterContainerView: FilterContainerView!
    
    private func setTitle() {
        filterContainerView.setTitle(text: "인원")
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeButtonClicked),
                                               name: .CloseButtonClicked,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resetButtonClicked),
                                               name: .ResetButtonClicked,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doneButtonClicked),
                                               name: .DoneButtonClicked,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(numberChanged),
                                               name: .NumberChanged,
                                               object: nil)
    }
    
    private func setGuestStackView() {
        filterContainerView.addSubviewInFilterView(view: guestStackView)
        guestStackView.topAnchor.constraint(equalTo: filterContainerView.filterView.topAnchor).isActive = true
        guestStackView.bottomAnchor.constraint(equalTo: filterContainerView.filterView.bottomAnchor).isActive = true
        guestStackView.leadingAnchor.constraint(equalTo: filterContainerView.filterView.leadingAnchor).isActive = true
        guestStackView.trailingAnchor.constraint(equalTo: filterContainerView.filterView.trailingAnchor).isActive = true

    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: .NumberCancel,
                                            object: nil)
        })
    }
    
    @objc func resetButtonClicked() {
        guestStackView.reset()
    }
    
    @objc func numberChanged() {
        guestStackView.isZero() ? filterContainerView.doneButtonDisenabled() : filterContainerView.doneButtonEnabled()
    }
    
    @objc func doneButtonClicked() {
        let result = guestStackView.totalGuest()
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: .NumberDone,
                                            object: nil,
                                            userInfo: ["result" : result])
        })
    }
}

extension Notification.Name {
    static let NumberCancel = Notification.Name("NumberCancel")
    static let NumberDone = Notification.Name("NumberDone")
}
