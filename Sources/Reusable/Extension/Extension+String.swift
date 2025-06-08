//
//  Extension+String.swift
//  ChatterBox
//
//  Created by Siddharth Dave on 3/31/25.
//

import UIKit


extension String {
   public func width(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
