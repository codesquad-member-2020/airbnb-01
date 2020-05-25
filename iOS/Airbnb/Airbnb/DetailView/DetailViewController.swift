//
//  DetailViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationItem.r
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath)
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset: CGFloat = scrollView.contentOffset.y / 150
        
        if offset > 1 {
            offset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusView?.backgroundColor = color
        } else {
            if offset < 0 {
                offset = 0
            }
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusView?.backgroundColor = color
        }
    }
}
