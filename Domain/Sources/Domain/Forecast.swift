//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

public struct Forecast {
    public let locationName: String
    public let country: String
    public let current: Current
    public let days: [ForecastDay]
    
    public init(locationName: String, country: String, current: Current, days: [ForecastDay]) {
        self.locationName = locationName
        self.country = country
        self.current = current
        self.days = days
    }
}
