//
//  ViewController+Extension.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit

fileprivate var aView: UIView?

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
    
    func showSpinner() {
        DispatchQueue.main.async {
            if aView != nil && self.view.subviews.contains(aView!) { return }
            aView = (self.parent != nil) ? UIView(frame: self.parent!.view.bounds) : UIView(frame: self.view.bounds)
            guard let containerView = aView else { return }
            containerView.backgroundColor = UIColor.clear
            self.view.addSubview(containerView)
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            aView?.removeFromSuperview()
            aView = nil
        }
    }
}
