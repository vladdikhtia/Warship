//
//  EnemyAPIError.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 16/03/2024.
//

import Foundation

enum EnemyAPIError: Error {
        case invalidURL
        case badServerResponse
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case networkError(URLError)
        case decodingError(DecodingError)

    
    var customDescription: String {
            switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .badServerResponse:
                return "The server response was not recognized."
            case .invalidStatusCode(let statusCode):
                return "Failed to fetch data. Status code: \(statusCode)."
            case .invalidData:
                return "The data received from the server is invalid."
            case .networkError(let urlError):
                switch urlError.code {
                case .notConnectedToInternet:
                    return "You appear to be offline. Please check your internet connection."
                case .timedOut:
                    return "The request timed out. Please try again."
                case .cannotFindHost:
                    return "A server with the specified hostname could not be found."
                default:
                    return "A network error occurred: \(urlError.localizedDescription)"
                }
            case .decodingError(let decodingError):
                return decodingError.customDescription
            }
        }

    
}
extension DecodingError {
    var customDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "Type mismatch for type \(type) in JSON: \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            return "Value not found for type \(type) in JSON: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "Missing key '\(key.stringValue)' in JSON: \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "Data corrupted in JSON: \(context.debugDescription)"
        @unknown default:
            return "Unknown decoding error occurred."
        }
    }
    
}
