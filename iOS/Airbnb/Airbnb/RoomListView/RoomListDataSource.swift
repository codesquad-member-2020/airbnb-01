//
//  RoomListDataSource.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class RoomListDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModel: RoomListViewModel? {
        didSet {
            NotificationCenter.default.post(name: .ViewModelChanged,
                                            object: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.roomListManager.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomListCell else {return UICollectionViewCell()}
        cell.likeButton.setRadius()
        guard let room = viewModel?.roomListManager.room(of: indexPath.item) else {return cell}
        cell.configure(about: room)
        for image in room.images {
            guard let url = URLBinder.shared.localUrl(index: room.id, of: image.url) else {
                return cell
            }
            let indices = room.updatedIndices(url: image.url)
            cell.updateImage(indices: indices, url: url)
        }
        
        return cell
    }
}

extension Notification.Name {
    static let ViewModelChanged = Notification.Name("viewModelChanged")
}
