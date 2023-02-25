//
//  Container+RegisterRouter.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerRouter(root: UINavigationController) {
        register(RouterProtocol.self) {_ in Router(rootController: root)}
    }
}
