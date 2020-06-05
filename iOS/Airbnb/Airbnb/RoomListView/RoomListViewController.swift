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
    @IBOutlet weak var priceButton: FilterButton!
    @IBOutlet weak var searchTextField: PaddingTextField!
    @IBAction func calendarButtonClicked(_ sender: FilterButton) {
        guard let calendarViewController = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else {return}
        calendarViewController.modalPresentationStyle = .overFullScreen
        present(calendarViewController, animated: true)
    }
    @IBAction func numberButtonClicked(_ sender: FilterButton) {
        guard let numberViewController = storyboard?.instantiateViewController(withIdentifier: "NumberViewController") as? NumberViewController else {return}
        numberViewController.modalPresentationStyle = .overFullScreen
        present(numberViewController, animated: true)
    }
    @IBAction func PriceButtonClicked(_ sender: FilterButton) {
        guard let priceViewController = storyboard?.instantiateViewController(withIdentifier: "PriceViewController") as? PriceViewController else {return}
        priceViewController.modalPresentationStyle = .overFullScreen
        present(priceViewController, animated: true)
    }
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        guard let mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {return}
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    private var imageUseCase = ImageUseCase(networkManager: NetworkManager())
    private var useCase = RoomListUseCase(networkManager: NetworkManager())
    
    private var viewModel: RoomListViewModel?
    
    private var dataSource = RoomListDataSource()
    private var filterManager = FilterManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setCollectionView()
        setObserver()
        searchTextField.delegate = self
        guard #available(iOS 13, *) else {
            setTabBarImage()
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dateDone(_:)),
                                               name: .DateDone,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addGuestInfo(_:)),
                                               name: .NumberDone,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(priceDone(_:)),
                                               name: .PriceDone,
                                               object: nil)
    }
    
    private func setCollectionView() {
        roomListCollectionView.dataSource = dataSource
        roomListCollectionView.delegate = self
        roomListCollectionView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                           action: #selector(collectionViewTouched(gesture:))))
    }
    
    private func setMockUseCase() {
        useCase.requestMockRoomList(successHandler: { [unowned self] in
            self.viewModel = RoomListViewModel(roomListManager: RoomManager(editingStyle: .none, roomList: $0),
                                               handler: { [unowned self] manager in
                                                switch manager.editingStyle {
                                                case .none:
                                                    self.roomListCollectionView.reloadData()
                                                case let .insert(_, indexPath):
                                                    self.roomListCollectionView.performBatchUpdates({
                                                        self.roomListCollectionView.insertItems(at: [indexPath])
                                                    }, completion: nil)
                                                }})
            self.dataSource.viewModel = self.viewModel
        })
    }
    
    private func setUseCase() {
        filterManager.page = 0
        roomListCollectionView.setContentOffset(.zero, animated: false)
        useCase.requestRoomList(queryString: filterManager.queryString(),
                                failureHandler: { [unowned self] in AlertView.alertError(viewController: self, message: $0)},
                                successHandler: { [unowned self] in
                                    guard $0.count != 0 else {
                                        AlertView.alertError(viewController: self, message: "검색 결과가 없습니다!")
                                        return
                                    }
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
                                    NotificationCenter.default.post(name: .ViewModelChanged,
                                                                    object: nil)})
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
            imageUseCase.enqueueImages(images: room.images,
                                       failureHandler: { [unowned self] in AlertView.alertError(viewController: self, message: $0) },
                                       completed: { URLBinder.shared.updateURL(roomID: room.id, serverURL: $0, localURL: $1) })
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
    
    @objc func dateDone(_ notification: Notification) {
        guard let dateFilter = notification.userInfo?["dateFilter"] as? DateFilter else {return}
        filterManager.dateFilter = dateFilter
        filterButtons[0].selected()
        setUseCase()
        if filterManager.dateFilter != nil, filterManager.guestInfo != nil {
            priceButton.isHidden = false
        }
    }
    
    @objc func addGuestInfo(_ notification: Notification) {
        guard let totalGuest = notification.userInfo?["result"] as? [String] else {return}
        filterManager.guestInfo = GuestInfo(adult: totalGuest[0], youth: totalGuest[1], infants: totalGuest[2])
        filterButtons[1].selected()
        setUseCase()
        if filterManager.dateFilter != nil, filterManager.guestInfo != nil {
            priceButton.isHidden = false
        }
    }
    
    @objc func priceDone(_ notification: Notification) {
        guard let min = notification.userInfo?["lower"] as? String,
            let max = notification.userInfo?["max"] as? String else {return}
        
        filterManager.priceFilter = PriceFilter(min: min, max: max)
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
        
        guard let count = viewModel?.roomListManager.count else {return}
        if indexPath.item == count - 1 {
            filterManager.page = count / 10
            useCase.requestRoomList(queryString: filterManager.queryString(),
                                    failureHandler: {[unowned self] in AlertView.alertError(viewController: self, message: $0)},
                                    successHandler: {
                                        $0.forEach { [unowned self] in
                                            self.viewModel?.appendRoom(room: $0)
                                            URLBinder.shared.registerRoomID(room: $0)
                                        }
                                        NotificationCenter.default.post(name: .ViewModelChanged,
                                                                        object: nil)})}
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension RoomListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let location = textField.text, location != "" else {
            AlertView.alertError(viewController: self, message: "검색어를 입력해주세요!")
            return true
        }
        filterManager.currentLocation = location
        filterManager.page = 0
        setUseCase()
        self.view.endEditing(true)
        return true
    }
}
