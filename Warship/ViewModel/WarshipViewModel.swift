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
    
    private let service = WarshipDataService()

    
    init() {
        fetchEnemies()
    }
    
    
    func fetchEnemies() {
        service.fetchMessage { enemies, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                self.errorMessage = error.localizedDescription
                                return
                            }
                            self.enemy = enemies ?? nil
                        }
                    }
        }
    
        
}


