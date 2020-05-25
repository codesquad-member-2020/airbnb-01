//
//  RoomListDataSource.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class RoomListDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModel: RoomListViewModel?
    private var imageUseCase = ImageUseCase(networkManager: NetworkManager())
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.roomListManager.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomListCell else {return UICollectionViewCell()}
        cell.likeButton.setRadius()
        guard let room = viewModel?.roomListManager.room(of: indexPath.item) else {return cell}
        cell.configure(about: room)
        room.images.forEach {
            imageUseCase.requestImage(imageURLPath: $0.url.trimmingCharacters(in: .whitespaces), failureHandler: {_ in}, completed: {
                cell.setImage(url: $0)
            })
        }
        
        return cell
    }
}
