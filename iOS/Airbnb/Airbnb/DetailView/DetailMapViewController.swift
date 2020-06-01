//
//  DetailMapViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/27.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailMapViewController: UIViewController {
    
    var roomInfo: RoomDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        showMap()
    }
    
    func showMap() {
        guard let roomInfo = roomInfo else {return}
        let coordinate = roomInfo.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = roomInfo.name
        marker.snippet = roomInfo.location
        marker.map = mapView
    }
}
