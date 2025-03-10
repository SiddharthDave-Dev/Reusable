//
//  NavigateToViewController.swift
//  EyeMeasure
//
//  Created by Siddharth Dave on 11/25/24.
//

import Foundation
import UIKit

public class NavigateToViewController {
    
    @MainActor public static let shared = NavigateToViewController()
    
    public init() {}

    @MainActor // ✅ Ensure this function runs on the main thread
    public func navigateToViewController(from viewController: UIViewController, identifier: String) {
        guard let storyboard = viewController.storyboard else {
            print("Error: Storyboard not found for \(viewController).")
            return
        }
        
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) // ✅ No Optional Binding
        
        if let navigationController = viewController.navigationController {
            navigationController.pushViewController(vc, animated: true)
        } else {
            print("Warning: NavigationController not found. Presenting modally.")
            viewController.present(vc, animated: true, completion: nil)
        }
    }
    
    @MainActor // ✅ Ensure this function runs on the main thread
    public func navigateToViewController<T: UIViewController>(
        from viewController: UIViewController,
        identifier: String,
        data: ((T) -> Void)? = nil
    ) {
        guard let storyboard = viewController.storyboard else {
            print("Error: Storyboard not found for \(viewController).")
            return
        }
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            print("Error: ViewController with identifier \(identifier) not found or wrong type.")
            return
        }
        
        // ✅ Ensure `data` runs on the main thread
        data?(vc)

        if let navigationController = viewController.navigationController {
            navigationController.pushViewController(vc, animated: true)
        } else {
            print("Warning: NavigationController not found. Presenting modally.")
            viewController.present(vc, animated: true, completion: nil)
        }
    }
}
