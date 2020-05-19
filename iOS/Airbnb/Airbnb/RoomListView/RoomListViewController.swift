//
//  FirstViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class RoomListViewController: UIViewController {

    @IBOutlet var filterButtons: [FilterButton]!
    @IBOutlet weak var roomListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        roomListCollectionView.dataSource = self
        roomListCollectionView.delegate = self
    }
    
    private func setButton() {
        filterButtons.forEach {
            $0.setRadius()
        }
        roomListCollectionView.delaysContentTouches = false
    }
}

extension RoomListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomListCell else {return UICollectionViewCell()}
        cell.likeButton.setRadius()
        return cell
    }
}

extension RoomListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.4)
    }
}

