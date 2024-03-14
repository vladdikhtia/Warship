//
//  WarshipDataService.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

class WarshipDataService {
    
    private let urlString = "https://russianwarship.rip/api/v2/statistics/latest"
    
    func fetchMessage(completion: @escaping(Enemy?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Bad Http")
                return
            }
            print(httpResponse)

            
            guard httpResponse.statusCode == 200 else {
                print("Failed to fetch with status code: \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                return
            }
            print(data)
            
            guard let enemy = try? JSONDecoder().decode(Enemy.self, from: data) else {
                print("DEBUG: Failed to decode coins")
                return
            }
            print("DEBUG: Enemy decoded:\n \(enemy)")
//            for en in enemy {
            print("DEBUG: Day number: \(enemy.data.stats.tanks)")
//            }
            
            completion(enemy, nil)
        }.resume()
    }
    
}
