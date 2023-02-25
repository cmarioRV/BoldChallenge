//
//  MainCoordinator.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

class MainCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    private let router: RouterProtocol
    private let factory: MainFactory
    
    init(router: RouterProtocol, factory: MainFactory) {
        self.router = router
        self.factory = factory
    }
    
    private func showSearchViewController() {
        let searchViewController = self.factory.instantiateSearchViewController()
        searchViewController.onShowForecast = { [unowned self] result in
            self.showForecastViewController(query: result)
        }
        self.router.setRootModule(searchViewController, hideBar: false)
    }
    
    private func showForecastViewController(query: String) {
        let forecastViewController = self.factory.instantiateForecastViewController()
        forecastViewController.query = query
        self.router.push(forecastViewController, animated: true)
    }
    
    override func start() {
        self.showSearchViewController()
    }
}
