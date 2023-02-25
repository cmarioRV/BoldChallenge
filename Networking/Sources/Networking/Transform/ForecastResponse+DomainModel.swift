//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Domain
import Core

extension ForecastResponse: DTOMapper {
    public func toDomainModel() -> Domain.Forecast? {
        
        guard let locationName = self.location?.name,
              let countryName = self.location?.country,
              let days = self.forecast?.forecastday else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return Domain.Forecast(locationName: locationName, country: countryName, current: .init(temperature: self.current?.tempC, state: self.current?.condition?.text, stateIcon: iconUrlWithoutStartingSlashes(self.current?.condition?.icon)), days: days.compactMap { .init(date: dateFormatter.date(from: $0.date!), avgTemperature: $0.day?.avgtempC, state: $0.day?.condition?.text, stateIcon: iconUrlWithoutStartingSlashes($0.day?.condition?.icon), maxtemperature: $0.day?.maxtempC, mintemperature: $0.day?.mintempC) })
    }
    
    private func iconUrlWithoutStartingSlashes(_ iconUrl: String?) -> String? {
        guard let iconUrl = iconUrl, iconUrl.hasPrefix("//") else { return iconUrl }
        return "https:\(iconUrl)"
    }
}
