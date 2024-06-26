//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ahmed Adel on 01/04/2024.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
        
    }
}
