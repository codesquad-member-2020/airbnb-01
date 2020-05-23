//
//  FirstViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import Alamofire

class RoomListViewController: UIViewController {
    
    @IBOutlet var filterButtons: [FilterButton]!
    @IBOutlet weak var roomListCollectionView: UICollectionView!
    @IBOutlet weak var mapButton: UIButton!
    
    private var useCase = RoomListUseCase(networkManager: NetworkManager())
    
    private var viewModel: RoomListViewModel?
    private var dataSource = RoomListDataSource() {
        didSet {
            roomListCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        roomListCollectionView.dataSource = dataSource
        roomListCollectionView.delegate = self
        setUseCase()
        guard #available(iOS 13, *) else {
            setTabBarImage()
            return
        }
    }
    
    private func setUseCase() {
        useCase.requestRoomList(
            failureHandler: { [unowned self] in
                AlertView.alertError(viewController: self, message: $0)
            },
            successHandler: { [unowned self] in
                self.viewModel = RoomListViewModel(roomListManager: Manager<Room>(editingStyle: .none, roomList: $0), handler: { [unowned self] manager in
                    switch manager.editingStyle {
                    case .none:
                        self.roomListCollectionView.reloadData()
                    case let .insert(_, indexPath):
                        self.roomListCollectionView.performBatchUpdates({
                            self.roomListCollectionView.insertItems(at: [indexPath])
                        }, completion: nil)
                    }
                })

                self.dataSource.viewModel = self.viewModel
        })
    }
    
    private func setTabBarImage() {
        guard let items = self.tabBarController?.tabBar.items else {return}
        items[0].image = UIImage(named: "magnifyingGlass")
        items[1].image = UIImage(named: "heart")
        items[1].selectedImage = UIImage(named: "heartFill")
    }
    
    private func setButton() {
        filterButtons.forEach {
            $0.setRadius()
        }
        roomListCollectionView.delaysContentTouches = false
    }
}

extension RoomListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: 350)
    }
}

