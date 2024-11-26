//
//  ContentView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Text("map view")
                .tabItem {
                    Label("Map", systemImage: "house.fill")
                }
            Text("favorites view")
                .tabItem {
                    Label("Favorites", systemImage: "house.fill")
                }
            Text("community view")
                .tabItem {
                    Label("Community", systemImage: "house.fill")
                }
        }
    }
    
    func testing() {
        let test = MaxHeap()
        if test.isEmpty() {
            print("heap is empty!!")
        }
    }
}

#Preview {
    ContentView()
}
