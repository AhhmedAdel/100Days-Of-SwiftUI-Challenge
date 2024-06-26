//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ahmed Adel on 08/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var redText = false
    var body: some View {
        Button("Hello, World") {
            redText.toggle()
        }
        .foregroundColor(redText ? .red : .blue)
    }
}

#Preview {
    ContentView()
}
