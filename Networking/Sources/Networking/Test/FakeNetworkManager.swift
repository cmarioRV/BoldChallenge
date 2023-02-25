//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Moya

struct FakeNetworkManager: Networkable {
    var service = MoyaProvider<Service>()
    
    func getSearch(query: String, completion: @escaping ([SearchResponse]?, Error?) -> Void) -> Cancellable {
        let response = [
            SearchResponse(id: 1, name: "Medellin", region: "Antioquia", country: "Colombia", lat: 6, lon: -75, url: nil),
            SearchResponse(id: 2, name: "Bogota", region: "Cundinamarca", country: "Colombia", lat: 4, lon: -74, url: nil)
        ]
        completion(response, nil)
        return CancellableToken { }
    }
    
    func getForecast(query: String, days: Int, completion: @escaping (ForecastResponse?, Error?) -> Void) -> Cancellable {
        let forecastDays: [Forecastday] = [
            .init(date: "2023-02-25", day: .init(Day(maxtempC: 25, mintempC: 18, avgtempC: 22, condition: .init(text: "Calm", icon: nil)))),
            .init(date: "2023-02-26", day: .init(Day(maxtempC: 23, mintempC: 15, avgtempC: 20, condition: .init(text: "Cold", icon: nil)))),
            .init(date: "2023-02-27", day: .init(Day(maxtempC: 22, mintempC: 13, avgtempC: 18, condition: .init(text: "Windy", icon: nil))))
        ]
        let response = ForecastResponse(location: .init(name: "Medellin", country: "Colombia"), current: .init(tempC: 22, condition: .init(text: "Windy", icon: nil)), forecast: .init(.init(forecastday: forecastDays)))
        
        completion(response, nil)
        return CancellableToken { }
    }
}
