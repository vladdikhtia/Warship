//
//  WarshipViewModel.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import Foundation

class WarshipViewModel: ObservableObject {
    @Published var enemy: Enemy?
    @Published var errorMessage: String?
//    @Published var enemyIcon: EnemyIcon.Data?
    
    private let service = WarshipDataService()

    
    init() {
        fetchEnemy()
//        fetchEnemyIcon()
    }
    
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
    
//    func fetchEnemyIcon() {
//        service.fetchEnemyIcon { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let icon):
//                    self?.enemyIcon = icon
//                case .failure(let error):
//                    self?.errorMessage = error.customDescription
//                }
//            }
//        }
//    }
}


