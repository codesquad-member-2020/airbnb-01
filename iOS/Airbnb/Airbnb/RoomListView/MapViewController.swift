//
//  MapViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    private var latitude = 34.758040
    private var longitude = 127.660205
    private let useCase = RooomListInMapUseCase(networkManager: NetworkManager())
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        sendCurrentLocation()
    }
    private var roomList = [MapViewRoomList]() {
        didSet {
            mapView.clear()
            roomList.forEach {
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude))
                marker.map = mapView
                marker.title = $0.name
                marker.snippet = $0.location
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(mapLoaded(_:)),
                                               name: .MapLoaded,
                                               object: nil)
        showMap()
    }
    
    private func showMap() {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 11)
        mapView.camera = camera
        mapView.delegate = self
    }
    
    private func sendCurrentLocation() {
        let origin = mapView.projection.coordinate(for: mapView.frame.origin)
        let end = mapView.projection.coordinate(for: CGPoint(x: mapView.frame.width, y: mapView.frame.height))
        NotificationCenter.default.post(name: .MapLoaded,
                                        object: nil,
                                        userInfo: ["origin" : origin, "end" : end])
    }
    
    @objc func mapLoaded(_ notification: Notification) {
        guard let origin = notification.userInfo?["origin"] as? CLLocationCoordinate2D else {return}
        guard let end = notification.userInfo?["end"] as? CLLocationCoordinate2D else {return}
        useCase.requestRoomList(queryString: EndPoint.leftTopLatitude + String(origin.latitude) + "&" + EndPoint.leftTopLongitude + String(origin.longitude) + "&" + EndPoint.rightBottomLatitude + String(end.latitude) + "&" + EndPoint.rightBottomLongitude + String(end.longitude),
                                failureHandler: {[unowned self] in
                                    AlertView.alertError(viewController: self, message: $0)},
                                successHandler: {[unowned self] in
                                    self.roomList = $0})
    }
}

extension Notification.Name {
    static let MapLoaded = Notification.Name("MapLoaded")
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if mapView.camera.zoom < 11 {
            searchButton.alpha = 0.5
            searchButton.isEnabled = false
        } else {
            searchButton.alpha = 1
            searchButton.isEnabled = true
        }
    }
}
