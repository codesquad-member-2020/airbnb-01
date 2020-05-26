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
    
    private var xibName = String(describing: ScrollViewWithPageControlView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setXib()
    }
    
    private func setXib() {
        let bundle = Bundle(for: ScrollViewWithPageControlView.self)
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
