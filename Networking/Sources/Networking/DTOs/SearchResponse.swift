//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

typealias SearchResult = [SearchResponse]

struct SearchResponse: Codable {
    var id: Int?
    public var name, region, country: String?
    var lat, lon: Double?
    var url: String?
}


