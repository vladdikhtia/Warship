//
//  WarshipDataService.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func getEnemy() async throws -> Enemy
}

protocol URLSessionProtocol {
    func data(for url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(for url: URL) async throws -> (Data, URLResponse) {
        try await self.data(from: url)
    }
}
class MockDataService: NetworkServiceProtocol {
    var enemyToReturn: Enemy?
    var errorToThrow: Error?
    
    func getEnemy() async throws -> Enemy {
        if let error = errorToThrow {
            throw error
        }
        if let enemy = enemyToReturn {
            return enemy
        }
        fatalError("MockNetworkService not configured properly")
    }
}


// mock urlSession for testing
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func data(for url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}


class WarshipDataService: NetworkServiceProtocol {
    private let urlString: String
    private let urlSession: URLSessionProtocol
    
    init(
        urlString: String = "https://russianwarship.rip/api/v2/statistics/latest",
        urlSession: URLSessionProtocol = URLSession.shared
    ) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getEnemy() async throws -> Enemy {
        
        guard let url = URL(string: urlString) else {
            throw EnemyAPIError.invalidURL
        }
        do {
            let (data, response) = try await urlSession.data(for: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("DEBUG: Bad Server Response")
                throw EnemyAPIError.badServerResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                print("DEBUG: Failed to fetch with status code: \(httpResponse.statusCode)")
                throw EnemyAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw EnemyAPIError.invalidData
            }
            
            do {
                let enemy = try JSONDecoder().decode(Enemy.self, from: data)
                return enemy
            } catch let decodingError as DecodingError {
                print("DEBUG: Decoding error occurred: \(decodingError)")
                throw EnemyAPIError.decodingError(decodingError)
            }
        } catch let urlError as URLError {
            print("DEBUG: Network error occurred: \(urlError)")
            throw EnemyAPIError.networkError(urlError)
        } catch {
            print("error JSON Decoder: \(error)")
            throw error
        }
    }
}
