//
//  File.swift
//  
//
//  Created by Mario Rúa on 24/02/23.
//

import Foundation
import Moya
import Core

enum Service {
    case search(query: String)
    case forecast(query: String, days: Int)
}

extension Service: TargetType {
    var baseURL: URL {
        return AppConfiguration.Api.baseURL
    }
    
    var path: String {
        switch self {
        case .search:
            return "search.json"
        case .forecast:
            return "/forecast.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let query):
            return .requestParameters(parameters: ["key": AppConfiguration.Api.token, "q": query], encoding: URLEncoding.default)
        case .forecast(let query, let days):
            return .requestParameters(parameters: ["key": AppConfiguration.Api.token, "q": query, "days": days], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
}
