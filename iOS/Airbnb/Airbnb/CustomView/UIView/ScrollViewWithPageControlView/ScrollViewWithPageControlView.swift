//
//  ScrollViewWithPageControlView.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/26.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class ScrollViewWithPageControlView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBInspectable var imageViewCornerRadius: CGFloat = 0
    
    private var xibName = String(describing: ScrollViewWithPageControlView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
        imageScrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
        imageScrollView.delegate = self
    }
    
    private func setXib() {
        let bundle = Bundle(for: ScrollViewWithPageControlView.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func appendImageView() {
        let imageView = UIImageView()
        imageStackView.addArrangedSubview(imageView)
        imageView.image = UIImage(named: "codesquad")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.imageScrollView.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageViewCornerRadius
        imageView.contentMode = .scaleAspectFit
        pageControl.numberOfPages = imageStackView.subviews.count
    }
}

extension ScrollViewWithPageControlView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(page)
    }
}
