//
//  PriceViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
        setTitle()
        setObserver()
        graphView.addTarget(self,
                            action: #selector(rangeSliderValueChanged(_:)),
                            for: .valueChanged)
        filterContainerView.addSubviewInFilterView(view: graphView)
        setUseCase()
    }
    
    override func viewDidLayoutSubviews() {
        setGrahpView()
    }
    
    private let useCase = PriceUseCase(networkManager: NetworkManager())
    private var graphView = RangeSlider()
    private var prices: [Int]?
    private let minPrice = 0
    private let maxPrice = 100000
    private var lower: Int?
    private var upper: Int?
    @IBOutlet weak var filterContainerView: FilterContainerView!
    
    private func setViewController() {
        filterContainerView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
    }
    
    private func setTitle() {
        filterContainerView.setTitle(text: "가격")
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
    }
    
    private func setGrahpView() {
        let bounds = filterContainerView.filterView.bounds
        let frame = filterContainerView.filterView.frame
        graphView.frame = CGRect(origin: CGPoint(x: (frame.width - bounds.width * 0.9) / 2, y: bounds.minY), size: CGSize(width: bounds.width * 0.9, height: bounds.height))
    }
    
    private func setUseCase() {
        useCase.requestPrice(queryString: FilterManager.shared.queryString(),
                             failureHandler: {[unowned self] in
                                AlertView.alertError(viewController: self, message: $0)},
                             successHandler: {[unowned self] in
                                self.prices = $0})
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: .PriceCancel,
                                            object: nil)
        })
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let lower = Int(rangeSlider.lowerValue * 1000000)
        let upper = Int(rangeSlider.upperValue * 1000000)
        self.lower = lower
        self.upper = upper
    }
    
    @objc func resetButtonClicked() {
        graphView.reset()
    }
    
    @objc func doneButtonClicked() {
        guard let lower = lower, let upper = upper else {return}
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: .PriceDone,
                                            object: nil,
                                            userInfo: ["lower" : lower, "upper" : upper])
        })
    }
}

extension Notification.Name {
    static let PriceCancel = Notification.Name("PriceCancel")
    static let PriceDone = Notification.Name("PriceDone")
}
