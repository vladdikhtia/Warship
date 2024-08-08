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
    
    private let service = WarshipDataService()

    func fetchEnemy() {
        service.fetchEnemy { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let enemy):
                    self?.enemy = enemy
                case .failure(let error):
                    self?.errorMessage = ("\(error.customDescription)")
                }
            }
        }
    }
    
    func fetchEnemyAsync() async  {
        do{
            self.enemy = try await service.fetchEnemyAsync()
        } catch let error as EnemyAPIError {
            self.errorMessage = error.customDescription
            print("DEBUG: Error occurred: \(error.customDescription)")
        }
        catch {
            print("DEBUG: Unknown error occurred: \(error.localizedDescription)")
            self.errorMessage = "\(error.localizedDescription)"
        }
    }
}


