//
//  Species.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/28/24.
//

import Foundation

struct Species: Codable {
    var result: [SpeciesResult]
}

struct SpeciesResult: Codable {
    var taxonid: Int
    var scientific_name: String
    var taxonomic_authority: String?
    var subspecies: String?
    var rank: String?
    var subpopulation: String?
    var category: String
}


struct SpeciesInformation: Codable {
    var result: [SpeciesInformationResult]
}

struct SpeciesInformationResult: Codable {
    var taxonid: Int
    var main_common_name: String?
    var scientific_name: String
    var category: String
    var population_trend: String
}

struct SpeciesNarrativeInformations: Codable {
    var taxonomicnotes: String
    var habitat: String
    var threats: String
}

struct SpeciesDetail: Identifiable {
    var id: Int
    var name: String
    var scientificName: String
    var redListCategory: String
    var populationTrend: String
    var description: String?
//    var favorite: Bool
    
    init(id: Int, name: String?, scientificName: String, redListCategory: String, populationTrend: String, description: String? = nil) {
        self.id = id
        self.name = name ?? scientificName
        self.scientificName = scientificName
        self.redListCategory = redListCategory
        self.populationTrend = populationTrend
        self.description = description
//        self.favorite = false
    }
}
