//
//  UIExtension + UITextView.swift
//  ChatterBox
//
//  Created by Siddharth Dave on 3/27/25.
//

import UIKit

import UIKit

private var placeholderKey: UInt8 = 0

extension UITextView: UITextViewDelegate {
    
    public var placeholderLabel: UILabel? {
        get { return objc_getAssociatedObject(self, &placeholderKey) as? UILabel }
        set { objc_setAssociatedObject(self, &placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public func setPlaceholder(_ text: String, color: UIColor = .white.withAlphaComponent(0.8)) {
        if placeholderLabel == nil {
            let label = UILabel()
            label.numberOfLines = 1
            label.textColor = color
            label.font = self.font
            label.text = text
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                label.centerYAnchor.constraint(equalTo: self.centerYAnchor) // Left-center alignment
            ])
            
            self.placeholderLabel = label
            self.delegate = self
            NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholder), name: UITextView.textDidChangeNotification, object: self)
        }
        placeholderLabel?.text = text
        updatePlaceholder()
    }
    
    public func refreshPlaceholder() {
        updatePlaceholder()
    }

    @objc public func updatePlaceholder() {
        placeholderLabel?.isHidden = !self.text.isEmpty
    }
}
