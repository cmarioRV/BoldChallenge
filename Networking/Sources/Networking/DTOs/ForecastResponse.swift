//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

struct ForecastResponse: Codable {
    var location: Location?
    var current: Current?
    var forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    var tempC: Double?
    var condition: Condition?

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

// MARK: - Condition
struct Condition: Codable {
    var text, icon: String?
}

// MARK: - Forecast
struct Forecast: Codable {
    var forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    var date: String?
    var day: Day?

    enum CodingKeys: String, CodingKey {
        case date
        case day
    }
}

// MARK: - Day
struct Day: Codable {
    var maxtempC, mintempC: Double?
    var avgtempC: Double?
    var condition: Condition?

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    var name, country: String?

    enum CodingKeys: String, CodingKey {
        case name, country
    }
}
