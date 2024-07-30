//
//  EnemyAPIError.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 16/03/2024.
//

import Foundation

enum EnemyAPIError: Error {
    case invalidData
    case invalidURL
    case jsonParsingFailure
    case badServerResponse
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .invalidURL:
            return "Invalid URL"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case .badServerResponse:
            return "Bad Server Response"
        case .requestFailed(let description):
            return "Request failed: \(description)"
        case .invalidStatusCode(let statusCode):
            return "Invalid status code: \(statusCode)"
        case .unknownError(let error):
            return "An unknown error occured:\n \(error.localizedDescription)"
        }
    }
}
