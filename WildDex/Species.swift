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
    var rank: String?
    var scientific_name: String
    var subpopulation: String?
    var subspecies: String?
    var taxonid: Int
}
