//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//
import Foundation

public struct ForecastDay {
    public let date: Date?
    public let avgTemperature: Double?
    public let state: String?
    public let stateIcon: String?
    public let maxtemperature: Double?
    public let mintemperature: Double?
    
    public init(date: Date?, avgTemperature: Double?, state: String?, stateIcon: String?, maxtemperature: Double?, mintemperature: Double?) {
        self.date = date
        self.avgTemperature = avgTemperature
        self.state = state
        self.stateIcon = stateIcon
        self.maxtemperature = maxtemperature
        self.mintemperature = mintemperature
    }
}
