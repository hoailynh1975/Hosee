//
//  Custom.swift
//  ModulPlacePicker
//
//  Created by Duc Anh on 3/21/19.
//  Copyright © 2019 Duc Anh. All rights reserved.
//

import UIKit


@IBDesignable
class DesignableImageView: UIImageView {}

@IBDesignable
class DesignableView: UIView {}

@IBDesignable
class DesignableButton: UIButton {}

// MARK: - Height for View with text

extension UIView {
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

// MARK: - Load Nib
extension UIView {
    static func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String(describing: viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    static func loadNib() -> Self {
        return loadNib(self)
    }
}


// MARK: - Attribute
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue == -1 {
                layer.cornerRadius = frame.width < frame.height ? frame.width * 0.5 : frame.height * 0.5
            } else {
                layer.cornerRadius = newValue
            }
            contentMode = .scaleToFill
            clipsToBounds = true
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

// MARK: - Animation
extension UIView {
    func animate(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
    func animateToSmaller(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
    func rotate(angle: CGFloat) {
        //        let radians = angle / 180.0 * CGFloat(Double.pi)
        let rotation = transform.rotated(by: angle)
        transform = rotation
    }
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    func shake() {
        backgroundColor = UIColor.orange.withAlphaComponent(0.2)
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1.2
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - Border 4 edges
fileprivate class Keys {
    static let TOP_BORDER = "top-border"
    static let BOTTOM_BORDER = "bottom-border"
    static let LEFT_BORDER = "left-border"
    static let RIGHT_BORDER = "right-boder"
}

extension UIView {
    
    @IBInspectable var topBorder: Bool {
        get {
            return layer.value(forKey: Keys.TOP_BORDER) != nil
        }
        set {
            addTopBorder(isActive: newValue)
        }
    }
    
    func addTopBorder(isActive: Bool, height: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: 0, width: layer.frame.width, height: height))
            border.layer.name = Keys.TOP_BORDER
            border.backgroundColor = borderColor
            layer.setValue(border, forKey: Keys.TOP_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.TOP_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.TOP_BORDER)
            }
        }
    }
    
    @IBInspectable var bottomBorder: Bool {
        get {
            return layer.value(forKey: Keys.BOTTOM_BORDER) != nil
        }
        set {
            addBottomBorder(isActive: newValue)
        }
    }
    
    func addBottomBorder(isActive: Bool, height: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: layer.frame.height - height, width: layer.frame.width, height: height))
            border.layer.name = Keys.BOTTOM_BORDER
            border.backgroundColor = borderColor
            layer.setValue(border, forKey: Keys.BOTTOM_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.BOTTOM_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.BOTTOM_BORDER)
            }
        }
    }
    @IBInspectable var leftBorder: Bool {
        get {
            return layer.value(forKey: Keys.LEFT_BORDER) != nil
        }
        set {
            addLeftBorder(isActive: newValue)
        }
    }
    
    func addLeftBorder(isActive: Bool, width: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: 0, width: width, height: layer.frame.height))
            border.layer.name = Keys.LEFT_BORDER
            border.backgroundColor = borderColor
            layer.setValue(border, forKey: Keys.LEFT_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.LEFT_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.LEFT_BORDER)
            }
        }
    }
    @IBInspectable var rightBorder: Bool {
        get {
            return layer.value(forKey: Keys.RIGHT_BORDER) != nil
        }
        set {
            addRightBorder(isActive: newValue)
        }
    }
    
    func addRightBorder(isActive: Bool, width: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: layer.frame.width - width, y: 0, width: width, height: layer.frame.height))
            border.layer.name = Keys.RIGHT_BORDER
            border.backgroundColor = borderColor
            layer.setValue(border, forKey: Keys.RIGHT_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.RIGHT_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.RIGHT_BORDER)
            }
        }
    }
}
