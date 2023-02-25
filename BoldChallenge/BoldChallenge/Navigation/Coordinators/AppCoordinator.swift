//
//  AppCoordinator.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

class AppCoordinator: BaseCoordinator {
    private let factory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, factory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        let coordinator = self.factory.instantiateMainCoordinator()
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
