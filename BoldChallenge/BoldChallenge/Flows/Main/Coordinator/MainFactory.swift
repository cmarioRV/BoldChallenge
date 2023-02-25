//
//  MainFactory.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Swinject

protocol MainFactory {
    func instantiateSearchViewController() -> SearchViewController
    func instantiateForecastViewController() -> ForecastViewController
}

extension Container: MainFactory {
    func instantiateSearchViewController() -> SearchViewController {
        return resolve(SearchViewController.self)!
    }
    
    func instantiateForecastViewController() -> ForecastViewController {
        return resolve(ForecastViewController.self)!
    }
}
