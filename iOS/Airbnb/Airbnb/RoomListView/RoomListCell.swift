//
//  RoomListCell.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/19.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class RoomListCell: UICollectionViewCell {
    
    private let xibName = String(describing: RoomListCell.self)
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var scrollViewWithPageControlView: ScrollViewWithPageControlView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var superHostImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
        guard #available(iOS 13, *) else {
            setSymbolImages()
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    func configure(about room: Room) {
        self.nameLabel.text = room.name
        guard let price = room.price?.price else {return}
        self.priceLabel.text = String(price)
        for _ in 0..<room.images.count {
            scrollViewWithPageControlView.appendImageView()
        }
    }
    
    private func setXib() {
        let bundle = Bundle(for: RoomListCell.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setSymbolImages() {
        ratingImage.image = UIImage(named: "starFill")?.withRenderingMode(.alwaysTemplate)
        ratingImage.tintColor = .systemPink
        superHostImage.image = UIImage(named: "house")?.withRenderingMode(.alwaysTemplate)
        superHostImage.tintColor = .systemPink
    }
    
    override func prepareForReuse() {
        scrollViewWithPageControlView.imageStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
