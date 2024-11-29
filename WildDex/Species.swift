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
    var kingdom_name: String
    var phylum_name: String
    var class_name: String
    var order_name: String
    var family_name: String
    var genus_name: String
    var scientific_name: String
    var taxonomic_authority: String?
    var infra_rank: String?
    var infra_name: String?
    var population: String?
    var category: String
    var main_common_name: String?
}
