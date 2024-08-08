//
//  WarshipDataService.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

class WarshipDataService {
    
    private let urlString = "https://russianwarship.rip/api/v2/statistics/latest"
    
    func fetchEnemy(completion: @escaping(Result<Enemy, EnemyAPIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Bad Http")
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Failed to fetch with status code: \(httpResponse.statusCode)")
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let enemy = try JSONDecoder().decode(Enemy.self, from: data)
                completion(.success(enemy))
            } catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    func fetchEnemyAsync() async throws -> Enemy {
        guard let url = URL(string: urlString) else {
            throw EnemyAPIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("DEBUG: Bad Server Response")
            throw EnemyAPIError.badServerResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            print("DEBUG: Failed to fetch with status code: \(httpResponse.statusCode)")
            throw EnemyAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            print("DEBUG: Invalid data")
            throw EnemyAPIError.invalidData
        }
        
        let enemy = try JSONDecoder().decode(Enemy.self, from: data)
        return enemy
    }
}
