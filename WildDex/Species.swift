//
//  Species.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/28/24.
//

import Foundation

struct Species: Codable {
    var result: [Result]
}

struct Result: Codable {
    var taxonid: Int
    var scientific_name: String
    var taxonomic_authority: String?
    var subspecies: String?
    var rank: String?
    var subpopulation: String?
    var category: String
//    var main_common_name: String?
}

struct SpeciesWithID: Identifiable {
    var id: Int
    var name: String
}
