//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Moya

struct NetworkManager: Networkable {
    let decoder = JSONDecoder()
    
    var service = MoyaProvider<Service>()
    
    func getSearch(query: String, completion: @escaping ([SearchResponse]?, Error?) -> Void) -> Cancellable {
        return service.request(.search(query: query)) { result in
            switch result {
            case let .success(response):
                if response.statusCode >= 200 && response.statusCode < 300 {
                    do {
                        let response = try decoder.decode(SearchResult.self, from: response.data)
                        completion(response, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else {
                    do {
                        let error = try decoder.decode(ServerError.self, from: response.data)
                        completion(nil, error)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    func getForecast(query: String, days: Int, completion: @escaping (ForecastResponse?, Error?) -> Void) -> Cancellable {
        service.request(.forecast(query: query, days: days)) { result in
            switch result {
            case let .success(response):
                if response.statusCode >= 200 && response.statusCode < 300 {
                    do {
                        let response = try decoder.decode(ForecastResponse.self, from: response.data)
                        completion(response, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else {
                    do {
                        let error = try decoder.decode(ServerError.self, from: response.data)
                        completion(nil, error)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
