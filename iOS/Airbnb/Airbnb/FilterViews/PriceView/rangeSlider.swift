//
//  rangeSlider.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class RangeSlider: UIControl {
    let minimumValue: CGFloat = 0
    let maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0
    var upperValue: CGFloat = 1
    
    var trackTintColor: UIColor = .lightGray
    var trackHighlightTintColor: UIColor = .darkGray
    
    private var previousLocation = CGPoint()
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.highlightedImage = UIImage(named: "thumb")
        imageView.image = UIImage(named: "thumb_origin")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private let upperThumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.highlightedImage = UIImage(named: "thumb")
        imageView.image = UIImage(named: "thumb_origin")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        addSubview(lowerThumbImageView)
        
        addSubview(upperThumbImageView)
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLayerFrames() {
        trackLayer.frame = CGRect(x: 0, y: bounds.midY * 1.5, width: bounds.width, height: 5)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOrigin(for: lowerValue), size: CGSize(width: 30, height: 30))
        upperThumbImageView.frame = CGRect(origin: thumbOrigin(for: upperValue
        ), size: CGSize(width: 30, height: 30))
    }
    
    func position(for value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    func reset() {
        lowerValue = 0
        upperValue = 1
        updateLayerFrames()
    }
    
    private func thumbOrigin(for value: CGFloat) -> CGPoint {
        let x = position(for: value) - lowerThumbImageView.frame.width / 2.0
        return CGPoint(x: x, y:  trackLayer.frame.midY - lowerThumbImageView.frame.height / 2)
    }
}

extension RangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        setNeedsDisplay()
        updateLayerFrames()
        
        CATransaction.commit()
        sendActions(for: .valueChanged)
        return true
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
}
