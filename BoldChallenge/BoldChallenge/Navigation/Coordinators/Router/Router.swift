//
//  Router.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit

protocol RouterProtocol: Presentable {
    func push(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
}

final class Router: NSObject, RouterProtocol {
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
    
    func toPresent() -> UIViewController? {
        return self.rootController
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }

        self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: false)
        self.rootController?.isNavigationBarHidden = hideBar
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}
