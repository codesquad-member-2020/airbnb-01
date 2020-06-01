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
    @IBOutlet weak var mapButton: UIButton!
    
    private var imageUseCase = ImageUseCase(networkManager: NetworkManager())
    private var useCase = RoomListUseCase(networkManager: NetworkManager())
    
    private var viewModel: RoomListViewModel?
    private var dataSource = RoomListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setCollectionView()
        setUseCase()
        setObserver()
        guard #available(iOS 13, *) else {
            setTabBarImage()
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(viewModelChanged),
                                               name: .ViewModelChanged,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(urlBinded(_:)),
                                               name: .URLBinded,
                                               object: nil)
    }
    
    private func setCollectionView() {
        roomListCollectionView.dataSource = dataSource
        roomListCollectionView.delegate = self
        roomListCollectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collectionViewTouched(gesture:))))
    }
    
    private func setMockUseCase() {
        useCase.requestMockRoomList(successHandler: { [unowned self] in
            self.viewModel = RoomListViewModel(roomListManager: RoomManager(editingStyle: .none, roomList: $0), handler: { [unowned self] manager in
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
    
    private func setUseCase() {
        useCase.requestRoomList(
            failureHandler: { [unowned self] in
                AlertView.alertError(viewController: self, message: $0)
            },
            successHandler: { [unowned self] in
                self.viewModel = RoomListViewModel(roomListManager: RoomManager(editingStyle: .none, roomList: $0), handler: { [unowned self] manager in
                    switch manager.editingStyle {
                    case .none:
                        self.roomListCollectionView.reloadData()
                    case let .insert(_, indexPath):
                        self.roomListCollectionView.performBatchUpdates({
                            self.roomListCollectionView.insertItems(at: [indexPath])
                        }, completion: nil)
                    }
                })
                $0.forEach {
                    URLBinder.shared.registerRoomID(room: $0)
                }
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
    
    @objc func urlBinded(_ notification: Notification) {
        guard let roomID = notification.userInfo?["roomID"] as? Int else {return}
        guard let index = viewModel?.roomListManager.index(findBy: roomID) else {return}
        let updateCellIndexPath = IndexPath(item: index, section: 0)
        roomListCollectionView.reloadItems(at: [updateCellIndexPath])
    }
    
    @objc func viewModelChanged() {
        viewModel?.roomListManager.roomList.forEach {
            let room = $0
            imageUseCase.enqueueImages(images: room.images, failureHandler: { [unowned self] in
                AlertView.alertError(viewController: self, message: $0)
            }, completed: {
                URLBinder.shared.updateURL(roomID: room.id, serverURL: $0, localURL: $1)
            })
        }
    }
    
    @objc func collectionViewTouched(gesture: UITapGestureRecognizer) {
        let touchLocation:CGPoint = gesture.location(ofTouch: 0, in: roomListCollectionView)
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        guard let indexPath = roomListCollectionView.indexPathForItem(at: touchLocation) else {return}
        guard let roomId = viewModel?.roomListManager.room(of: indexPath.item).id else {return}
        detailViewController.roomId = roomId
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension RoomListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        guard let cell = cell as? RoomListCell else {return}
        
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .allowUserInteraction, animations: {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        })
    }
}