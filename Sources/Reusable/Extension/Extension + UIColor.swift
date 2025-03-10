//
//  Extension + UIColor.swift
//  TierList
//
//  Created by Siddharth Dave on 11/28/24.
//

import Foundation
import UIKit

extension UIColor {
    convenience public init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public func toHex() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Convert the color components to hex format
        let hexString = String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        
        return hexString
    }
}

extension UIColor {
    public func isLightColor() -> Bool {
        guard let components = self.cgColor.components, components.count >= 3 else { return false }
        
        let red = components[0] * 0.299
        let green = components[1] * 0.587
        let blue = components[2] * 0.114
        
        let luminance = red + green + blue // Standard luminance formula
        
        return luminance > 0.7 // Adjust threshold as needed
    }
}
