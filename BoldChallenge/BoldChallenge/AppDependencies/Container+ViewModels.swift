//
//  Container+ViewModels.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import NetworkingInterface
import Swinject

extension Container {
    func registerViewModels() {
        register(SearchViewModelType.self) {r in SearchViewModel(networkingProvider: r.resolve(NetworkingModuleInterface.self)!)}
        register(ForecastViewModelType.self) {r in ForecastViewModel(networkingProvider: r.resolve(NetworkingModuleInterface.self)!)}
    }
}
