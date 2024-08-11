//
//  WarshipViewModel.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

@MainActor
final class WarshipViewModel: ObservableObject {
    @Published var enemy: Enemy?
    @Published var errorMessage: String?
    
    
    // Dependency Injection
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = WarshipDataService()) {
        self.networkService = networkService
    }
    
    func fetchEnemyAsync() async {
        do{
            self.enemy = try await networkService.getEnemy()
        } catch let error as EnemyAPIError {
            self.errorMessage = error.customDescription
            print("DEBUG: Error occurred: \(error)")
        }
        catch {
            print("DEBUG: Unknown error occurred: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
}


