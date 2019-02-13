//
//  VDSLoaderView.swift
//  VDSLoader
//
//  Created by Vimal Das on 12/02/19.
//  Copyright © 2019 Vimal. All rights reserved.
//

import UIKit

class VDSLoaderView: UIView {
    
    @IBInspectable var color:UIColor = UIColor(red: 228/255, green: 200/255, blue: 108/255, alpha: 1) { didSet{setupViews()} }
    @IBInspectable var speed:CGFloat = 0.7 { didSet{setupViews()} }
    @IBInspectable var isFancy:Bool = false { didSet{setupViews()} }
    @IBInspectable var lineScale:CGFloat = 3 { didSet{setupViews()} }
    
    private var fancy: [UIColor] = [.orange, .green, .cyan, .magenta]
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .clear
        for v in subviews {
            v.removeFromSuperview()
        }
        
        let size = min(bounds.width, bounds.height)
        
        for i in 0..<4 {
            let view = UIView()
            view.frame.size = CGSize(width: size/2, height: size/2)
            view.tag = i
            view.backgroundColor = .clear
            view.layer.cornerRadius = size/4
            view.layer.masksToBounds = true
            view.layer.borderWidth = 5
            view.layer.borderColor = isFancy ? fancy[i].cgColor : color.cgColor
            addSubview(view)
            view.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            
            view.animateBorderWidth(toValue: 1, duration: TimeInterval(speed))
            UIView.animate(withDuration: TimeInterval(speed), delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
                
                view.layer.borderWidth = 1
                let transform = CGAffineTransform(rotationAngle:  CGFloat( CGFloat(i) * 45 * CGFloat.pi / 180))
                
                view.transform = view.transform.concatenating(transform).scaledBy(x: self.lineScale, y: 1)
                
            }) { (true) in
                
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear , .repeat], animations: {
                let rotateTransform = CGAffineTransform(rotationAngle: -.pi)
                self.transform = self.transform.concatenating(rotateTransform)
            }) { (true) in
                
            }
        }
        
    }
}
extension UIView {
    func animateBorderWidth(toValue: CGFloat, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .greatestFiniteMagnitude
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }
}
