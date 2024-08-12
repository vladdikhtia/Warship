//
//  EnemyAPIError.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 16/03/2024.
//

import Foundation

enum EnemyAPIError: Error, Equatable {
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
    
    static func ==(lhs: EnemyAPIError, rhs: EnemyAPIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.badServerResponse, .badServerResponse),
            (.invalidData, .invalidData):
            return true
            
        case (.invalidStatusCode(let lhsStatusCode), .invalidStatusCode(let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
            
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return lhsError == rhsError
            
        case (.decodingError(let lhsDecodingError), .decodingError(let rhsDecodingError)):
            return lhsDecodingError == rhsDecodingError
            
        default:
            return false
        }
    }
    
    
}
extension DecodingError: Equatable {
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
    
    public static func ==(lhs: DecodingError, rhs: DecodingError) -> Bool {
        switch (lhs, rhs) {
        case (.typeMismatch(let lhsType, let lhsContext), .typeMismatch(let rhsType, let rhsContext)):
            return lhsType == rhsType && lhsContext.debugDescription == rhsContext.debugDescription
            
        case (.valueNotFound(let lhsType, let lhsContext), .valueNotFound(let rhsType, let rhsContext)):
            return lhsType == rhsType && lhsContext.debugDescription == rhsContext.debugDescription
            
        case (.keyNotFound(let lhsKey, let lhsContext), .keyNotFound(let rhsKey, let rhsContext)):
            return lhsKey.stringValue == rhsKey.stringValue && lhsContext.debugDescription == rhsContext.debugDescription
            
        case (.dataCorrupted(let lhsContext), .dataCorrupted(let rhsContext)):
            return lhsContext.debugDescription == rhsContext.debugDescription
            
        @unknown default:
            return false
        }
    }
    
}
