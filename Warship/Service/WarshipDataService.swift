//
//  WarshipDataService.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

class WarshipDataService {
    
    private let urlString = "https://russianwarship.rip/api/v2/statistics/latest"
    //   private let iconUrlString = "https://russianwarship.rip/api/v2/terms/en"
    
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
        
        do{
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
        } catch let error as EnemyAPIError {
            print("DEBUG: An EnemyAPIError occurred: \(error.customDescription)")
            throw error
        }
    }
    
    
    
    
    
    //    func fetchEnemyIcon(completion: @escaping(Result<EnemyIcon.Data, EnemyAPIError>) -> Void) {
    //        guard let url = URL(string: iconUrlString) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let error = error {
    //                completion(.failure(.unknownError(error: error)))
    //                return
    //            }
    //
    //            guard let httpResponse = response as? HTTPURLResponse else {
    //                print("Bad Http")
    //                completion(.failure(.requestFailed(description: "Request failed")))
    //                return
    //            }
    //
    //            guard httpResponse.statusCode == 200 else {
    //                print("Failed to fetch with status code: \(httpResponse.statusCode)")
    //                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                print("Bad data")
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //            print(data)
    //            do{
    //                let enemyIcon = try JSONDecoder().decode(EnemyIcon.self, from: data)
    //                print(enemyIcon.data)
    //
    //                completion(.success(enemyIcon.data))
    //            } catch {
    //                print("DEBUG: Failed to decode with error \(error)")
    //                completion(.failure(.jsonParsingFailure))
    //            }
    //        }.resume()
    
}
