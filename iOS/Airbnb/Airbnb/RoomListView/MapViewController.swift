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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMap()
    }
    
    func showMap() {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        mapView.delegate = self
        let origin = mapView.projection.coordinate(for: mapView.frame.origin)
        let end = mapView.projection.coordinate(for: CGPoint(x: mapView.frame.width, y: mapView.frame.height))
        print(EndPoint.leftTopLatitude + String(end.latitude) + "&" + EndPoint.leftTopLongitude + String(origin.longitude) + "&" + EndPoint.rightBottomLatitude + String(origin.latitude) + "&" + EndPoint.rightBottomLongitude + String(end.longitude))
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}
