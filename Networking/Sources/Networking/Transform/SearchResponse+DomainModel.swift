//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Domain
import Core

extension SearchResponse: DTOMapper {
    public func toDomainModel() -> Search? {
        guard let locationName = self.name, let countryName = self.country else { return nil }
        return Search(locationName: locationName, countryName: countryName)
    }
}
