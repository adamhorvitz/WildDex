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
           .navigationTitle("Explore")
       }
   }
}

#Preview {
    HomeView(dataLoaded: .constant(false))
}
