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
    @State var sortSelection: SortingAlgorithm = .heapSort
    
    enum SortingAlgorithm: String, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        case heapSort = "Heap Sort"
        case quickSort = "Quick Sort"
    }
    
    var body: some View {
       NavigationStack {
           ScrollView {
               if dataLoaded {
                   VStack(alignment: .leading) {
                       Picker("Sorting Algorithm", selection: $sortSelection) {
                           ForEach(SortingAlgorithm.allCases) { sortingAlgorithm in
                               Text(sortingAlgorithm.rawValue)
                           }
                       }
                       .pickerStyle(.segmented)
                       .task(id: sortSelection) {
                           if sortSelection == .heapSort {
                               await speciesData.heapSort()
                           } else {
                               await speciesData.quickSort_()
                           }
                       }
//                       Text("Find endangered animals near you")
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
