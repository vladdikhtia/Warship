//
//  Enemy.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//


import Foundation

struct Enemy: Codable {
    let message: String
    let data: Data
}

struct Data: Codable {
    let date: String
    let day: Int
    let stats: Stats
    let increase: Increase
}

struct Stats: Codable {
    let tanks: Int
    let personnelUnits: Int
    let armouredFightingVehicles: Int
    let artillerySystems: Int
    let mlrs: Int
    let aaWarfareSystems: Int
    let planes: Int
    let helicopters: Int
    let vehiclesFuelTanks: Int
    let warshipsCutters: Int
    let cruiseMissiles: Int
    let uavSystems: Int
    let specialMilitaryEquip: Int
    let atgmSrbmSystems: Int
    let submarines: Int
    
    enum CodingKeys: String, CodingKey {
    case tanks, mlrs, planes, helicopters, submarines
        case personnelUnits = "personnel_units"
        case armouredFightingVehicles = "armoured_fighting_vehicles"
        case artillerySystems = "artillery_systems"
        case aaWarfareSystems = "aa_warfare_systems"
        case vehiclesFuelTanks = "vehicles_fuel_tanks"
        case warshipsCutters =  "warships_cutters"
        case cruiseMissiles = "cruise_missiles"
        case uavSystems = "uav_systems"
        case specialMilitaryEquip = "special_military_equip"
        case atgmSrbmSystems = "atgm_srbm_systems"
    }
}

struct Increase: Codable {
    let personnelUnits: Int
    let tanks: Int
    let armouredFightingVehicles: Int
    let artillerySystems: Int
    let mlrs: Int
    let aaWarfareSystems: Int
    let planes: Int
    let helicopters: Int
    let vehiclesFuelTanks: Int
    let warshipsCutters: Int
    let cruiseMissiles: Int
    let uavSystems: Int
    let specialMilitaryEquip: Int
    let atgmSrbmSystems: Int
    let submarines: Int
    
    enum CodingKeys: String, CodingKey {
    case tanks, mlrs, planes, helicopters, submarines
        case personnelUnits = "personnel_units"
        case armouredFightingVehicles = "armoured_fighting_vehicles"
        case artillerySystems = "artillery_systems"
        case aaWarfareSystems = "aa_warfare_systems"
        case vehiclesFuelTanks = "vehicles_fuel_tanks"
        case warshipsCutters =  "warships_cutters"
        case cruiseMissiles = "cruise_missiles"
        case uavSystems = "uav_systems"
        case specialMilitaryEquip = "special_military_equip"
        case atgmSrbmSystems = "atgm_srbm_systems"
    }
}

