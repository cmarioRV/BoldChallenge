//
//  Container+ViewControllers.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerViewControllers() {
        register(SearchViewController.self) {r in SearchViewController()}
            .initCompleted { (r, vc) in
                vc.viewModel = r.resolve(SearchViewModelType.self)
            }
        
        register(ForecastViewController.self) {r in ForecastViewController()}
            .initCompleted { (r, vc) in
                vc.viewModel = r.resolve(ForecastViewModelType.self)
            }
    }
}
