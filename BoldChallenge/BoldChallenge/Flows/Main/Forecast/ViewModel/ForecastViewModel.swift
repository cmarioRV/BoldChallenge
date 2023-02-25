//
//  ForecastViewModel.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Domain
import NetworkingInterface

internal protocol ForecastViewModelInputs {
    func getForecast(location: String)
}

internal protocol ForecastViewModelOutputs {
    var forecast: Bind<Domain.Forecast> { get }
    var error: Bind<Error?> { get }
    var isBussy: Bind<Bool> { get }
}

internal protocol ForecastViewModelType {
    var inputs: ForecastViewModelInputs { get }
    var outputs: ForecastViewModelOutputs { get }
}

internal final class ForecastViewModel: ForecastViewModelType, ForecastViewModelInputs, ForecastViewModelOutputs
{
    var inputs: ForecastViewModelInputs { return self }
    var outputs: ForecastViewModelOutputs { return self }
    
    var forecast = Bind<Domain.Forecast>(.init(locationName: "", country: "", current: .init(temperature: nil, state: nil, stateIcon: nil), days: []))
    var error = Bind<Error?>(nil)
    var isBussy = Bind<Bool>(false)

    private let networkingProvider: NetworkingModuleInterface
    private var results: [Search] = []
    
    init(networkingProvider: NetworkingModuleInterface) {
        self.networkingProvider = networkingProvider
    }
    
    func getForecast(location: String) {
        if isBussy.value { return }
        isBussy.value = true
        
        networkingProvider.getForecast(query: location, days: 3) { [weak self] forecast, error in
            guard let self = self else { return }
            self.isBussy.value = false
            
            guard let forecast = forecast else {
                self.error.value = error
                self.isBussy.value = false
                return
            }
            
            self.forecast.value = forecast
        }
    }
}
