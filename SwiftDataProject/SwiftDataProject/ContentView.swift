//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Ahmed Adel on 06/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showinUpcomingOnly = false
    @State private var path = [User]()
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showinUpcomingOnly ? .now : .distantPast)
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)

                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
                
                Button(showinUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showinUpcomingOnly.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
