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
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    private let detailViewUseCase = DetailViewUseCase(networkManager: NetworkManager())
    private let bookingUseCase = BookingUseCase(networkManager: NetworkManager())
    private let imageUseCase = ImageUseCase(networkManager: NetworkManager())
    private var detailRoomInformation: RoomDetail? {
        didSet {
            setAccommodationInfoView()
            setMapView()
            setBookingButton()
            guard let images = detailRoomInformation?.images else {return}
            setImageUseCase(images: images)
            setDescriptionLabel()
            reviewCollectionView.reloadData()
        }
    }
    
    var roomId: Int?
    var price: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.alpha = 0
        setObserver()
        setNavigationController()
        setModelUseCase()
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
    }
    
    deinit {
        self.navigationController?.delegate = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(urlBinded(_:)),
                                               name: .URLBinded,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(bookingButtonCliked),
                                               name: .BookingButtonClicked,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doneClicked),
                                               name: .DateDone,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doneClicked),
                                               name: .NumberDone,
                                               object: nil)
    }
    
    private func setBookingButton() {
        bookingButtonView.bookingButton.isEnabled = true
        bookingButtonView.bookingButton.setTitle("예약", for: .normal)
        bookingButtonView.bookingButton.alpha = 1
    }
    
    private func setAccommodationInfoView() {
        guard let roomInfo = detailRoomInformation else {return}
        accommodationInfoView.setNameLabel(name: roomInfo.name)
        
        let rating = Double(roomInfo.reviews.reduce(0) {$0 + $1.star}) / 3.0
        
        accommodationInfoView.setRatingLabel(rating: round(rating * 100) / 100)
        bookingButtonView.setRating(rating: round(rating * 100) / 100)
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
    
    private func setDescriptionLabel() {
        guard let date = FilterManager.shared.dateFilter else {
            bookingButtonView.setDescriptionLabel(text: "요금을 확인하려면 날짜를 입력하세요.")
            return}
        guard let guest = FilterManager.shared.guestInfo else {
            bookingButtonView.setDescriptionLabel(text: "요금을 확인하려면 인원을 입력하세요.")
            return
        }
        guard let price = price else {return}
        
        let totalPirce = guest.totalIntegerGuest() * Int(date.endDate.timeIntervalSince(date.startDate) / 86400) * price
        
        bookingButtonView.setDescriptionLabel(text: "\(totalPirce)원에 예약하세요!")
    }
    
    private func setImageUseCase(images: [Image]) {
        imageUseCase.enqueueImages(images: images,
                                   failureHandler: { [unowned self] in AlertView.alertError(viewController: self, message: $0) },
                                   completed: { [unowned self] in
                                    guard let roomId = self.roomId else {
                                        AlertView.alertError(viewController: self, message: "숙소 정보가 없습니다.")
                                        return
                                    }
                                    URLBinder.shared.updateURL(roomID: roomId, serverURL: $0, localURL: $1)
                                    self.reviewCollectionView.reloadData()})
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
    
    private func setModelUseCase() {
        guard let roomId = roomId else {return}
        detailViewUseCase.requestDetailView(roomId: roomId,
                                            failureHandler: { [unowned self] in AlertView.alertError(viewController: self, message: $0) },
                                            successHandler: { [unowned self] in
                                                URLBinder.shared.registerRoomID(room: $0)
                                                for _ in 0..<$0.images.count {
                                                    self.scrollViewWithPageControlView.appendImageView()
                                                }
                                                
                                                self.detailRoomInformation = $0 })
    }
    
    @objc func urlBinded(_ notification: Notification) {
        guard let serverURL = notification.userInfo?["serverURL"] as? String else {return}
        guard let roomId = roomId else {return}
        guard let localURL = URLBinder.shared.localUrl(index: roomId, of: serverURL) else {return}
        guard let indices = detailRoomInformation?.updatedIndices(url: serverURL) else {return}
        scrollViewWithPageControlView.updateImage(indices: indices, url: localURL)
    }
    
    @objc func actionButtonPushed() {
    }
    
    @objc func likeButtonPushed() {
        
    }
    
    @objc func doneClicked() {
        setDescriptionLabel()
    }
    
    @objc func bookingButtonCliked() {
        guard FilterManager.shared.dateFilter != nil else {
            guard let calendarViewController = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else {return}
            calendarViewController.modalPresentationStyle = .overFullScreen
            present(calendarViewController, animated: true)
            return
        }
        
        guard FilterManager.shared.guestInfo != nil else {
            guard let numberViewController = storyboard?.instantiateViewController(withIdentifier: "NumberViewController") as? NumberViewController else {return}
            numberViewController.modalPresentationStyle = .overFullScreen
            present(numberViewController, animated: true)
            return
        }
        guard let roomId = roomId else {return}
        
        bookingUseCase.booking(roomId: roomId,
                               failureHandler: {[unowned self] in AlertView.alertError(viewController: self, message: $0)},
                               successHandler: {[unowned self] in
                                AlertView.alert(viewController: self, message: $0)})
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

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailRoomInformation?.reviews.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
        guard let review = detailRoomInformation?.reviews[indexPath.item] else {return UICollectionViewCell()}
        cell.descriptionLabel.text = review.content
        cell.emailInfo.text = review.email
        guard let url = URL(string: review.profileURL) else {return cell}
        let data = try! Data(contentsOf: url)
        cell.profileImageView.image = UIImage(data: data)
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
