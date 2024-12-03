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
    @Published var species: [SpeciesDetail]
    var speciesForCountry: Species?
    
    init() {
        species = []
        speciesForCountry = nil
    }
    
    func getTopOfMaxHeap(num: Int = 10) async {
        guard let species = speciesForCountry else { return }
        var speciesHeap = MaxHeap()
        for animal in species.result {
            speciesHeap.insert(SpeciesNode(id: std.string(String(animal.taxonid)), count: Int32(animal.taxonid)))
        }
        for _ in 0..<num {
            let maxSpecies = speciesHeap.extractMax()
            do {
                let speciesDetail = try await getSpeciesInfo(id: String(maxSpecies.id))
                self.species.append(speciesDetail)
            } catch {
                print("error!!!!!")
            }
        }
    }
    
    func getSpeciesInfo(id: String) async throws -> SpeciesDetail {
        let apiKey = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee"
        if let url = URL(string: "https://apiv3.iucnredlist.org/api/v3/species/id/\(id)?token=\(apiKey)") {
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
                    let speciesInformation = try decoder.decode(SpeciesInformation.self, from: data)
                    if let species = speciesInformation.result.first {
                        let speciesDetail = SpeciesDetail(id: species.taxonid, name: species.main_common_name, scientificName: species.scientific_name, redListCategory: species.category, populationTrend: species.population_trend)
                        return speciesDetail
                    }
                    print("error: species has no result?")
                } catch {
                    print("decode error:", error)
                }
            } catch {
                print("load error:", error)
            }
        }
        throw NSError(domain: "", code: 1) // replace with custom error
    }
    
    func loadSpecies(for country: String) async {
        do {
            speciesForCountry = try await fetchData(country: country)
        } catch {
            print("Error: species does not exist")
        }
    }
    
    func fetchData(country: String) async throws -> Species {
        let apiKey = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee"
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
                    let species = try decoder.decode(Species.self, from: data)
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
        throw NSError(domain: "", code: 1) // replace with custom error
    }
}
