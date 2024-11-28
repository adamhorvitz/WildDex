//
//  ModelData.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/27/24.
//

import Foundation

//class SpeciesData: ObservableObject {
//    @Published var species:
    func fetchData() async -> [Result] {
        let apiKey = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee"
        if let url = URL(string: "https://apiv3.iucnredlist.org/api/v3/species/category/CR?token=" + apiKey) {
            var request = URLRequest(url: url)
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
                    for result in species.result {
                        print(result.rank, result.scientific_name, result.subpopulation, result.subspecies, result.taxonid)
                    }
                    return species.result
                } catch {
                    print("decode error:", error)
                }
            } catch {
                print("load error:", error)
                return []
            }
        }
        return []
    }
//}
