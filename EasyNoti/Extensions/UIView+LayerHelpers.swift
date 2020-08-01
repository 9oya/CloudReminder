//
//  UIView+LayerHelpers.swift
//  EasyNoti
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

extension UIView {
    func addShadowView(offset:CGSize=CGSize(width: 0, height: 3), opacity:Float=0.3, radius:CGFloat=3, color:CGColor=UIColor.darkGray.cgColor, maskToBounds:Bool=false) {
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
        self.layer.masksToBounds = maskToBounds
    }
    
    func startRotating(duration: Double = 5) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Double.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func showSpinner() {
        let spinner: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            if #available(iOS 13, *) {
                indicator.style = UIActivityIndicatorView.Style.large
            }
            indicator.color = .red
            indicator.layer.cornerRadius = 10.0
            indicator.startAnimating()
            indicator.tag = 475647
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
        }()
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        if let spinner = viewWithTag(475647){
            spinner.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
