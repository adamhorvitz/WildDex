//
//  ModelData.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/27/24.
//

import SwiftUI
import CoreLocation

@MainActor
class SpeciesData: ObservableObject {
    @Published var nearbySpecies: [SpeciesWithID]
    @Published var species: Species
    
    init() {
        nearbySpecies = []
        species = Species(result: [])
    }
    
    func getTopOfMaxHeap(num: Int = 10) async {
        var speciesHeap = MaxHeap()
        for animal in species.result {
            speciesHeap.insert(SpeciesNode(name: std.string(animal.scientific_name), count: Int32(animal.taxonid)))
        }
        for _ in 0..<num {
            let maxSpecies = speciesHeap.extractMax()
            nearbySpecies.append(SpeciesWithID(id: Int(maxSpecies.count), name: String(maxSpecies.name)))
        }
    }
    
    func getSpecies(for country: String) async {
        species = await fetchData(country: country)
    }
    
    func fetchData(country: String) async -> Species {
        let apiKey = ""
        if let url = URL(string: "https://apiv3.iucnredlist.org/api/v3/country/getspecies/\(country)?token=\(apiKey)") {
            let request = URLRequest(url: url)
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                do {
                    let decoder = JSONDecoder()
                    // Used the commented out code determine the keys in the data in order to make
                    // the `Item` struct. Replacing result.keys with result["record"] gave me the
                    // data in the "record" key, and I was able to adjust my struct accordingly.
                    //
//                     if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                         print("JSON Keys:", result["result"])
//                     }
                    var species = try decoder.decode(Species.self, from: data)
//                    species.result = Array(species.result[0...20])
                    for result in species.result {
                        print(result.taxonid, result.scientific_name)
                    }
                    return species
                } catch {
                    print("decode error:", error)
                }
            } catch {
                print("load error:", error)
            }
        }
        return Species(result: [])
    }
}
