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
    @IBAction func detailMap(_ sender: Any) {
        guard let detailMapViewController = storyboard?.instantiateViewController(withIdentifier: "DetailMapViewController") as? DetailMapViewController else {return}
        guard let roomInfo = detailRoomInformation else {return}
        detailMapViewController.modalPresentationStyle = .fullScreen
        detailMapViewController.roomInfo = roomInfo
        self.navigationController?.pushViewController(detailMapViewController, animated: true)
    }
    
    private let detailViewUseCase = DetailViewUseCase(networkManager: NetworkManager())
    private let imageUseCase = ImageUseCase(networkManager: NetworkManager())
    private var detailRoomInformation: RoomDetail? {
        didSet {
            setMapView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setModelUseCase(_:)),
                                               name: .PostRoomId, object: nil)
    }
    
    @objc func test(_ recognizer: UITapGestureRecognizer) {
        print(recognizer.state)
    }
    
    private func setMapView() {
        guard let roomInfo = detailRoomInformation else {return}
        let coordinate = roomInfo.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        mapView.camera = camera
        mapView.settings.scrollGestures = false
        mapView.settings.zoomGestures = false
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.layer.cornerRadius = 20
        setMarker(roomInfo: roomInfo)
    }
    
    private func setMarker(roomInfo: RoomDetail) {
        let coordinate = roomInfo.coordinate
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        
        marker.title = roomInfo.name
        marker.snippet = roomInfo.location
        marker.map = mapView
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
    }
    
    @objc func setModelUseCase(_ notification: Notification) {
        guard let roomId = notification.userInfo?["roomId"] as? Int else {return}
        detailViewUseCase.requestDetailView(roomId: roomId, failureHandler: { [unowned self] in
            AlertView.alertError(viewController: self, message: $0)
            }, successHandler: { [unowned self] in
                self.setImageUseCase(images: $0.images)
                self.detailRoomInformation = $0
        })
    }
    
    
    @objc func actionButtonPushed() {
    }
    
    @objc func likeButtonPushed() {
        
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}

extension Notification.Name {
    static let OpenDetailMap = Notification.Name("OpenDetailMap")
}
