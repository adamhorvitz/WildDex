//
//  WildDexApp.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI

@main
struct WildDexApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var speciesData = SpeciesData()
    @State var dataLoaded: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView(dataLoaded: $dataLoaded)
//                .environmentObject(locationManager)
                .environmentObject(speciesData)
                .task {
                    do {
                        let location = try await locationManager.requestLocation()
                        if let country = location.isoCountryCode {
                            print(country)
                            await speciesData.getSpecies(for: country)
                            await speciesData.getTopOfMaxHeap()
                            dataLoaded = true
                        }
                    } catch {
                        print("error!")
                    }
                }
        }
    }
}
