//
//  Container+Coordinators.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Swinject

extension Container {
    func registerCoordinators() {
        register(AppCoordinator.self) {r in AppCoordinator(router: r.resolve(RouterProtocol.self)!, factory: self)}.inObjectScope(.container)
        register(MainCoordinator.self) {r in MainCoordinator(router: r.resolve(RouterProtocol.self)!, factory: self)}.inObjectScope(.container)
    }
    
    func start() {
        resolve(AppCoordinator.self)!.start()
    }
}

extension Container: CoordinatorFactoryProtocol {
    func instantiateMainCoordinator() -> MainCoordinator {
        return resolve(MainCoordinator.self)!
    }
    
    func instantiateAppCoordinator() -> AppCoordinator {
        return resolve(AppCoordinator.self)!
    }
}
