//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

public protocol DTOMapper {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
