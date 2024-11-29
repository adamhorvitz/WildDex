//
//  ContentView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @Binding var dataLoaded: Bool
    var body: some View {
        TabView {
            HomeView(dataLoaded: $dataLoaded)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Text("map view")
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            Text("favorites view")
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            Text("community view")
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }
        }
    }
}

#Preview {
    ContentView(dataLoaded: .constant(false))
}
