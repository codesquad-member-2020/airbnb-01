//
//  ConfirmViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.loadResource(method: .get, headers: nil, bodys: nil, statusCode: 300, requestURL: EndPoint.defaultURL + EndPoint.booking, handler: {
            switch($0) {
            case .success(let data) :
                guard let data = data else {
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode([MyModel].self, from: data)
                    print(model)
                } catch {
                    AlertView.alertError(viewController: self, message: "Json decode error")
                }
                break
                
                
                break
            case .failure(let errpr):
                AlertView.alertError(viewController: self, message: errpr.localizedDescription)
            }
        })
    }
    
}
//
//extension ConfirmViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
//
//extension ConfirmViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 300)
//    }
//}


struct MyModel: Decodable {
    
    var id: Int
    var isCanceled: Bool
    var checkIn: String
    var checkOut: String
    var personCount: Int
    var totalPrice: Int
    var accommodation: Accommodation
    var images: [Image]
    var price: Price
    var bookedDate: [String]
    var reviews: [Review]
}


struct Accommodation: Decodable {
    var id: Int
    var name: String
    var type: String
    var location: String
    var guests: Int
    var coordinate: Coordinate
}
