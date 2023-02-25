//
//  CoordinatorFactory.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func instantiateAppCoordinator() -> AppCoordinator
    func instantiateMainCoordinator() -> MainCoordinator
}
