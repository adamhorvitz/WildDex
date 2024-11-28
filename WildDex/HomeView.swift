//
//  HomeView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI

struct HomeView: View {
   var body: some View {
       NavigationStack {
           ScrollView {
               VStack(alignment: .leading) {
                   Text("Find endangered animals near you")
                   ForEach(1..<5) { num in
                       GroupBox {
                           Text(String(num))
                               .frame(maxWidth: .infinity)
                       }
                   }
               }
               .padding()
           }
           .toolbar {
               Button(action: {}) {
                   Label("profile", systemImage: "person.crop.circle")
               }
           }
           .navigationTitle("Explore")
       }
       .task {
           var itemData = await fetchData()
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
   HomeView()
}
