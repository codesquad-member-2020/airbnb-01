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
    
    
    @IBOutlet weak var bookingButtonView: BookingButtonView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var scrollViewWithPageControlView: ScrollViewWithPageControlView!
    @IBOutlet weak var accommodationInfoView: AccommodationInfoView!
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
            setAccommodationInfoView()
            setMapView()
            setBookingButton()
        }
    }
    
    var roomId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.alpha = 0
        setNavigationController()
        setModelUseCase()
    }
    
    deinit {
        self.navigationController?.delegate = nil
    }
    
    private func setBookingButton() {
        bookingButtonView.bookingButton.isEnabled = true
        bookingButtonView.bookingButton.setTitle("예약 가능 여부 확인", for: .normal)
        bookingButtonView.bookingButton.alpha = 1
    }
    
    private func setAccommodationInfoView() {
        guard let roomInfo = detailRoomInformation else {return}
        accommodationInfoView.setNameLabel(name: roomInfo.name)
        accommodationInfoView.setRatingLabel(rating: 4.81)
        let addressList = roomInfo.location.components(separatedBy: " ")
        guard addressList.count >= 3 else {
            accommodationInfoView.setAddressLabel(address: addressList.joined(separator: " "))
            return
        }
        let address = (addressList.enumerated().filter {
            $0.offset < 3
        }.reduce(into: [String](), {
            $0.append($1.element)
        }).joined(separator: " "))
        accommodationInfoView.setAddressLabel(address: address)
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
        activityIndicator.stopAnimating()
        scrollView.alpha = 1
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
            }, completed: { _ in
                self.scrollViewWithPageControlView.appendImageView()
            })
        }
    }
    
    private func setNavigationController() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        let heartButton = LikeButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        heartButton.addTarget(self, action: #selector(likeButtonPushed), for: .touchUpInside)
        let likeButton = UIBarButtonItem(customView: heartButton)
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButtonPushed))
        
        self.navigationItem.setRightBarButtonItems([likeButton, actionButton], animated: true)
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
    }
    
    func setModelUseCase() {
        guard let roomId = roomId else {return}
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
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
