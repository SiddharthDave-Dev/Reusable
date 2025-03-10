//
//  Extension + UIView.swift
//  SpeakAI
//
//  Created by Siddharth Dave on 28/10/24.
//

import UIKit

extension UIView {
    
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    public var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public var isCircle: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            if newValue {
                layer.cornerRadius = min(bounds.width, bounds.height) / 2
                layer.masksToBounds = true
            } else {
                layer.cornerRadius = 0
                layer.masksToBounds = false
            }
        }
    }
    
    
    public func addDashedBorder(lineWidth: CGFloat = 2.0, lineDashPattern: [NSNumber] = [6, 3], borderColor: UIColor = .black, cornerRadius: CGFloat = 10.0) {
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = lineDashPattern
        
        // Create a path for the dashed border
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shapeLayer.path = path.cgPath
        
        // Add the shape layer as a sublayer
        layer.addSublayer(shapeLayer)
        
        // Set corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}


//import UIKit

extension UIView {
    /// Adds a top-to-bottom gradient layer with three colors to the view.
    /// - Parameters:
    ///   - colors: An array of three `UIColor` objects representing the gradient colors.
    ///   - locations: An array of numbers specifying the location of each gradient color.
    public func addThreeLayerGradient(
        colors: [UIColor],
        locations: [NSNumber] = [0.0, 0.5, 1.0]
    ) {
        guard colors.count == 3 else {
            print("Error: You must provide exactly 3 colors for the gradient.")
            return
        }
        
        // Create and configure the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // Top center
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // Bottom center
        
        // Remove any existing gradient layers to avoid overlapping
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        // Insert the gradient layer
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        // Update the gradient layer's frame based on the view's bounds
        self.layoutIfNeeded() // Ensure layout updates before setting the frame
        gradientLayer.frame = self.bounds
    }
    
    public func addTopBorderWithCorners(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
            // Ensure the layout is updated before drawing
            self.layoutIfNeeded()

            // Create a rounded path for the view's top corners
            let path = UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            )

            // Apply corner radius mask
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer  // Apply corner radius without clipping border

            // Create a precise border path (shrinking frame slightly to prevent clipping)
            let borderPath = UIBezierPath()
            borderPath.move(to: CGPoint(x: borderWidth / 2, y: cornerRadius)) // Start at left curve
            borderPath.addArc(
                withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: .pi,
                endAngle: .pi * 1.5,
                clockwise: true
            )
            borderPath.addLine(to: CGPoint(x: self.bounds.width - cornerRadius, y: 0)) // Top line
            borderPath.addArc(
                withCenter: CGPoint(x: self.bounds.width - cornerRadius, y: cornerRadius),
                radius: cornerRadius,
                startAngle: .pi * 1.5,
                endAngle: 0,
                clockwise: true
            )
            borderPath.addLine(to: CGPoint(x: self.bounds.width - borderWidth / 2, y: borderWidth / 2)) // Right end

            // Create the border layer
            let borderLayer = CAShapeLayer()
            borderLayer.path = borderPath.cgPath
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor  // Keep the inside transparent
            borderLayer.lineWidth = borderWidth

            // Add the border as a sublayer
            self.layer.addSublayer(borderLayer)
        }
}


extension UIView {
    public func superview<T>(of type: T.Type) -> T? {
        var view: UIView? = self
        while let current = view {
            if let match = current as? T {
                return match
            }
            view = current.superview
        }
        return nil
    }
}

extension UIView
{
    public func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
