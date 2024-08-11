////
////  EnemyIcon.swift
////  Warship
////
////  Created by Vladyslav Dikhtiaruk on 16/03/2024.
////
//
//import Foundation
//
//struct EnemyIcon: Codable {
//    let data: Data
//    
//    struct Data: Codable {
//        let personnelUnits: Icon
//        let tanks: Icon
//        let armouredFightingVehicles: Icon
//        let artillerySystems: Icon
//        let mlrs: Icon
//        let aaWarfareSystems: Icon
//        let planes: Icon
//        let helicopters: Icon
//        let vehiclesFuelTanks: Icon
//        let warshipsCutters: Icon
//        let uavSystems: Icon
//        let specialMilitaryEquip: Icon
//        let atgmSrbmSystems: Icon
//        let cruiseMissiles: Icon
//        let submarines: Icon
//        
//        enum CodingKeys: String, CodingKey {
//        case tanks, mlrs, planes, helicopters, submarines
//            case personnelUnits = "personnel_units"
//            case armouredFightingVehicles = "armoured_fighting_vehicles"
//            case artillerySystems = "artillery_systems"
//            case aaWarfareSystems = "aa_warfare_systems"
//            case vehiclesFuelTanks = "vehicles_fuel_tanks"
//            case warshipsCutters =  "warships_cutters"
//            case cruiseMissiles = "cruise_missiles"
//            case uavSystems = "uav_systems"
//            case specialMilitaryEquip = "special_military_equip"
//            case atgmSrbmSystems = "atgm_srbm_systems"
//        }
//    }
//    
//    struct Icon: Codable {
//        let icon: String
//    }
//}
