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
    @State var useCurrentLocation: Bool
    @State var country: String
    
    init() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "useCurrentLocation")
        useCurrentLocation = true
        country = defaults.string(forKey: "country") ?? "US"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(dataLoaded: $dataLoaded, useCurrentLocation: $useCurrentLocation, country: $country)
                .environmentObject(locationManager)
                .environmentObject(speciesData)
                .task {
                    do {
                        try await locationManager.requestLocation()
                        if let country = locationManager.location?.isoCountryCode {
                            UserDefaults.standard.set(country, forKey: "country")
                            self.country = country
                            print("country source:", self.country)
                            await speciesData.loadSpecies(for: country)
                            await speciesData.getTopOfMaxHeap()
                            dataLoaded = true
                        }
                    } catch {
                        UserDefaults.standard.set(false, forKey: "useCurrentLocation")
                        useCurrentLocation = false
                        await speciesData.loadSpecies(for: country)
                        await speciesData.getTopOfMaxHeap()
                        dataLoaded = true
                    }
                }
        }
    }
}
