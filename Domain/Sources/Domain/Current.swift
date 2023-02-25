//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

public struct Current {
    public let temperature: Double?
    public let state: String?
    public let stateIcon: String?
    
    public init(temperature: Double?, state: String?, stateIcon: String?) {
        self.temperature = temperature
        self.state = state
        self.stateIcon = stateIcon
    }
}
