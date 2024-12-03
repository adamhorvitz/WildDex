//
//  HomeView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var speciesData: SpeciesData
    @Binding var dataLoaded: Bool
    var body: some View {
       NavigationStack {
           ScrollView {
               if dataLoaded {
                   VStack(alignment: .leading) {
                       Text("Find endangered animals near you")
                       ForEach(speciesData.species) { species in
                           GroupBox {
                               HStack {
                                   Text(species.name)
                                   Text(String(species.id))
                               }
                               .frame(maxWidth: .infinity)
                           }
                       }
                   }
                   .padding()
               } else {
                   Text("Counting animals...")
               }
           }
           .toolbar {
               Button(action: {}) {
                   Label("profile", systemImage: "person.crop.circle")
               }
           }
           .navigationTitle("Explore")
       }
   }
    
   
//    func getHeap() {
//        var speciesArrayPtr = getSpeciesSorted()
//
//        while speciesArrayPtr != nil {
//            guard let newSpecies = speciesArrayPtr?.pointee?.pointee else { return }
//            species.append(newSpecies)
//            speciesArrayPtr = speciesArrayPtr?.advanced(by: 1)
//        }
//
//        for animal in species {
//            print(animal.name, " with ID ", animal.count)
//        }
//
////        (0 ..< 4).forEach { _ in
////            species.append(<#T##newElement: Species##Species#>)
//////            print(ptr?.advanced(by: $0).pointee)
////        }
//    }
}

#Preview {
    HomeView(dataLoaded: .constant(false))
}
