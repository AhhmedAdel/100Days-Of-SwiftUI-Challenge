//
//  ContentView.swift
//  Navigation
//
//  Created by Ahmed Adel on 16/03/2024.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
        }
    }
}


#Preview {
    ContentView()
}
