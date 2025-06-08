//
//  UIExtension + UITextView.swift
//  ChatterBox
//
//  Created by Siddharth Dave on 3/27/25.
//

import UIKit

private var placeholderKey: UInt8 = 0

extension UITextView: UITextViewDelegate {
    
    private var placeholderLabel: UILabel? {
        get { return objc_getAssociatedObject(self, &placeholderKey) as? UILabel }
        set { objc_setAssociatedObject(self, &placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func setPlaceholder(_ text: String, color: UIColor = .white.withAlphaComponent(0.8)) {
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
    
    func refreshPlaceholder() {
        updatePlaceholder()
    }

    @objc private func updatePlaceholder() {
        placeholderLabel?.isHidden = !self.text.isEmpty
    }
}

