//
//  ContentView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var speciesData: SpeciesData
    @State var selectedTab: Tab = .home
    @Binding var dataLoaded: Bool
    @Binding var useCurrentLocation: Bool
    @Binding var country: String
    
    enum Tab {
        case home, settings
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(dataLoaded: $dataLoaded)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            SettingsView(useCurrentLocation: $useCurrentLocation, country: $country)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
        .task(id: selectedTab) {
            if selectedTab == .home {
                if let loadedCountry = speciesData.country {
                    print("loadedCountry:", loadedCountry)
                    print("current country:", country)
                    if country != loadedCountry {
                        dataLoaded = false
                        await speciesData.loadSpecies(for: country)
                        await speciesData.heapSort()
                        dataLoaded = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    ContentView(dataLoaded: .constant(false))
//}
