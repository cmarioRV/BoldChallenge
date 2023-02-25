//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Swinject
import Domain
import Core
import NetworkingInterface
import Moya

public final class NetworkingModule: NetworkingModuleInterface {
    public var moduleAssembly: ModuleAssembly
    private var resolver: Resolver?
    
    public init(assembly: ModuleAssembly?) {
        if let assembly = assembly {
            self.moduleAssembly = assembly
        } else {
            self.moduleAssembly = NetworkingAssembly()
        }
        
        self.moduleAssembly.delegate = self
    }
    
    public convenience init() {
        self.init(assembly: nil)
    }
    
    public func getSearch(query: String, completion: @escaping ([Domain.Search]?, Error?) -> Void) -> Cancellable? {
        guard let provider = resolver?.resolve(Networkable.self) else {
            completion(nil, nil)
            return nil
        }

        return provider.getSearch(query: query, completion: { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            
            guard let response = response else {
                completion(nil, nil)
                return
            }
            
            completion(response.compactMap { $0.toDomainModel() }, nil)
        })
    }
    
    public func getForecast(query: String, days: Int, completion: @escaping (Domain.Forecast?, Error?) -> Void) -> Cancellable? {
        guard let provider = resolver?.resolve(Networkable.self) else {
            completion(nil, nil)
            return nil
        }
        
        return provider.getForecast(query: query, days: days) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            
            guard let response = response else {
                completion(nil, nil)
                return
            }
            
            completion(response.toDomainModel(), nil)
        }
    }
    
    public func loadedAssemblies(resolver: Resolver) {
        self.resolver = resolver
    }
}
