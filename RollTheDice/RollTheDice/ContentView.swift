//
//  ContentView.swift
//  RollTheDice
//
//  Created by Ahmed Adel on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDice = 0
    @State private var rolledDiceCount = 0
    @State private var previousRolls = [Int]()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text(String(currentDice))
                    .font(.system(size: 100))
                Spacer()
                if !previousRolls.isEmpty {
                    Text("Previous rolls")
                        .font(.headline.bold())
                        .multilineTextAlignment(.leading)
                        .padding()
                    Text(previousRolls.map { String($0) }.joined(separator: " "))
                        .multilineTextAlignment(.leading)
                    Text("Rolled Dice Count: \(rolledDiceCount)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                
                }
                Button("Roll") {
                    currentDice = Int.random(in: 1...6)
                    previousRolls.append(currentDice)
                    rolledDiceCount += 1
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                )
                .foregroundColor(.white)
            }
            .padding()
            .navigationTitle("Dice Roller")
        }
    }
}

#Preview {
    ContentView()
}
