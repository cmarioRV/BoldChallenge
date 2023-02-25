//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation

public struct ServerError: Error, Codable {
    let statusCode: Int
    let message: String
    
    func prettyPrinted() -> String {
        return message.replacingOccurrences(of: "Error: ", with: "")
    }
}

extension ServerError: LocalizedError {
    public var errorDescription: String? {
        get {
            return self.prettyPrinted()
        }
    }
}
