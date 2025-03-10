//
//  Extension + UITableView.swift
//  EyeMeasure
//
//  Created by Siddharth Dave on 11/25/24.
//

import UIKit

extension UITableView {
    /// Registers a nib-based cell with the table view.
    /// - Parameters:
    ///   - nibName: The name of the nib file.
    ///   - identifier: The reuse identifier for the cell.
    public func registerTableViewCell(withNibName nibName: String, identifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    public func registerTableViewHeaderAndFooterCell(withNibName nibName: String, identifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
