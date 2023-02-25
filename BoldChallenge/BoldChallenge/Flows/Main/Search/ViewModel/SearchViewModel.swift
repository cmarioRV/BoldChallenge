//
//  SearchViewModel.swift
//  BoldChallenge
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Domain
import NetworkingInterface
import Moya

internal protocol SearchViewModelInputs {
    func getWeather(inLocation location: String)
}

internal protocol SearchViewModelOutputs {
    var cellViewModels: Bind<[SearchTableViewCell.ViewModel]> { get }
    var error: Bind<Error?> { get }
    var isBussy: Bind<Bool> { get }
}

internal protocol SearchViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

internal final class SearchViewModel: SearchViewModelType, SearchViewModelInputs, SearchViewModelOutputs
{
    var inputs: SearchViewModelInputs { return self }
    var outputs: SearchViewModelOutputs { return self }
    
    var error = Bind<Error?>(nil)
    var isBussy = Bind<Bool>(false)
    var cellViewModels = Bind<[SearchTableViewCell.ViewModel]>([SearchTableViewCell.ViewModel]())
    private let networkingProvider: NetworkingModuleInterface
    private var cancellable: Cancellable?
    
    private var results: [Search] = []
    
    init(networkingProvider: NetworkingModuleInterface) {
        self.networkingProvider = networkingProvider
    }
    
    func getWeather(inLocation location: String) {
        if let cancellable = cancellable {
            cancellable.cancel()
        }
        
        if !isBussy.value {
            isBussy.value = true
        }
        
        cancellable = networkingProvider.getSearch(query: location) { [weak self] results, error in
            guard let self = self else { return }
            
            guard let results = results else {
                self.error.value = error
                self.isBussy.value = false
                return
            }
            
            self.results = results
            self.cellViewModels.value = results.map{ .init(locationName: $0.locationName, countryName: $0.countryName)  }
            self.isBussy.value = false
        }
    }
}
