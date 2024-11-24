//
//  ContentView.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onTapGesture {
                    testing()
                }
        }
        .padding()
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
