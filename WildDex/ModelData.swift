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
    var country: String?
    
    init() {
        species = []
        speciesForCountry = nil
    }
    
    func heapSort(num: Int = 10) async {
        guard let species = speciesForCountry else { return }
        self.species = []
        var speciesHeap = MinHeap()
        for creature in species.result {
            speciesHeap.insert(SpeciesNode(name: std.string(String(creature.scientific_name)), count: Int32(creature.taxonid)))
        }
        for _ in 0..<num {
            let minSpecies = speciesHeap.extractMin()
            do {
                let speciesDetail = try await getSpeciesInfo(name: String(minSpecies.name))
                self.species.append(speciesDetail)
            } catch {
                print("error!!!!!")
            }
        }
    }
    
    func quickSort_(num: Int = 10) async {
        print("quick sort sorted!")
        guard let species = speciesForCountry else { return }
        self.species = []
        var speciesManager = SpeciesManager()
        for creature in species.result {
            speciesManager.addSpecies(std.string(String(creature.scientific_name)), Int32(creature.taxonid))
        }
        for _ in 0..<num {
            let speciesName = speciesManager.getSpeciesAndRemove(0)
//            print("species name:", String(speciesName))
            do {
                let speciesDetail = try await getSpeciesInfo(name: String(speciesName))
                self.species.append(speciesDetail)
            } catch {
                print("another error :((((")
            }
        }
    }
    
//    func getNameVector() -> StringVector {
//        var vector = StringVector()
//        if let speciesList = speciesForCountry?.result {
//            for species in speciesList {
//                vector.push_back(std.string(species.scientific_name))
//            }
//        }
//        return vector
//    }
//    
//    func getIDVector() -> IntVector {
//        var vector = IntVector()
//        if let speciesList = speciesForCountry?.result {
//            for species in speciesList {
//                vector.push_back(Int32(species.taxonid))
//            }
//        }
//        return vector
//    }
    
    func getSpeciesInfo(name: String) async throws -> SpeciesDetail {
        let apiKey = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee"
        if let url = URL(string: "https://apiv3.iucnredlist.org/api/v3/species/\(name)?token=\(apiKey)") {
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
            self.country = country
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
