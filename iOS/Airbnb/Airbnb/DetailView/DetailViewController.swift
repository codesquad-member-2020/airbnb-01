//
//  DetailViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var scrollViewWithPageControlView: ScrollViewWithPageControlView!
    @IBOutlet weak var collectionView: UICollectionView!
    private let detailViewUseCase = DetailViewUseCase(networkManager: NetworkManager())
    private let imageUseCase = ImageUseCase(networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setModelUseCase(_:)),
                                               name: .PostRoomId, object: nil)
        let latitude =  35.3677151
        let longitude = 127.0344808
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        mapView.camera = camera
    }
    
    @objc func setModelUseCase(_ notification: Notification) {
        guard let roomId = notification.userInfo?["roomId"] as? Int else {return}
        detailViewUseCase.requestDetailView(roomId: roomId, failureHandler: { [unowned self] in
            AlertView.alertError(viewController: self, message: $0)
            }, successHandler: { [unowned self] in
                self.setImageUseCase(images: $0.images)
        })
    }
    
    private func setImageUseCase(images: [Image]) {
        images.forEach { [unowned self] in
            self.imageUseCase.requestImage(imageURLPath: $0.url, failureHandler: {
                AlertView.alertError(viewController: self, message: $0)
            }, completed: {
                self.scrollViewWithPageControlView.appendImageView(url: $0)
            })
        }
    }
    
    private func setNavigationController() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        let heartButton = LikeButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        heartButton.addTarget(self, action: #selector(likeButtonPushed), for: .touchUpInside)
        let likeButton = UIBarButtonItem(customView: heartButton)
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButtonPushed))
        
        self.navigationItem.setRightBarButtonItems([likeButton, actionButton], animated: true)
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
        self.navigationController?.hidesBarsOnTap = true
    }
    
    @objc func actionButtonPushed() {
    }
    
    @objc func likeButtonPushed() {
        
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}
