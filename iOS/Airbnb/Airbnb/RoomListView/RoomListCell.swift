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
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var superHostImage: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
        imageScrollView.delegate = self
        pageControl.numberOfPages = imageStackView.subviews.count
        guard #available(iOS 13, *) else {
            setImage()
            return
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
        imageScrollView.delegate = self
        pageControl.numberOfPages = imageStackView.subviews.count
    }
    
    private func setXib() {
        let bundle = Bundle(for: RoomListCell.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setImage() {
        ratingImage.image = UIImage(named: "starFill")?.withRenderingMode(.alwaysTemplate)
        ratingImage.tintColor = .systemPink
        superHostImage.image = UIImage(named: "house")?.withRenderingMode(.alwaysTemplate)
        superHostImage.tintColor = .systemPink
    }
}

extension RoomListCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset: Int = Int(scrollView.contentOffset.x)
        if currentOffset % Int(scrollView.frame.width) == 0 {
            pageControl.currentPage = currentOffset / Int(scrollView.frame.width)
        }
    }
}