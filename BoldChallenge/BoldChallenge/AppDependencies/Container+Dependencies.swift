//
//  Container+Dependencies.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerDependencies(rootViewController: UINavigationController) {
        registerCoordinators()
        registerViewModels()
        registerViewControllers()
        registerRouter(root: rootViewController)
        registerModules()
    }
}
