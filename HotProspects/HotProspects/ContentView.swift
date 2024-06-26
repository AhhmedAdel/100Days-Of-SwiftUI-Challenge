//
//  ContentView.swift
//  HotProspects
//
//  Created by Ahmed Adel on 27/04/2024.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        VStack {
            TabView {
                ProspectsView(filter: .none)
                    .tabItem {
                        Label("Everyone", systemImage: "person.3")
                    }
                ProspectsView(filter: .contacted)
                    .tabItem {
                        Label("Contacted", systemImage: "checkmark.circle")
                    }
                ProspectsView(filter: .uncontacted)
                    .tabItem {
                        Label("Uncontacted", systemImage: "questionmark.diamond")
                    }
                MeView()
                    .tabItem {
                        Label("Me", systemImage: "person.crop.square")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
