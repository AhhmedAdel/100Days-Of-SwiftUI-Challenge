//
//  ContentView.swift
//  LengthConversion
//
//  Created by Ahmed Adel on 04/02/2024.
//

import SwiftUI

struct ContentView: View {
    let units = ["meters", "kilometers", "feet", "yard", "miles"]

    @State private var currentUnit = "meters"
    @State private var convertedUnit = "kilometers"
    @State private var currentValue = ""
    @State private var convertedValue = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Select Units") {
                    Picker("Input Unit", selection: $currentUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Output Unit", selection: $convertedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Enter Value in \(currentUnit)") {
                    TextField("Enter Value", text: $currentValue)
                        .keyboardType(.decimalPad)
                }
                Section("Converted Value in \(convertedUnit)") {
                    Text(convertedValue)
                }
                Button("Convert") {
                    convertLength()
                }
            }
            .navigationTitle("Length Converter")
        }
    }

    private func convertLength() {
        guard let inputValue = Double(currentValue) else {
            // Handle invalid input
            return
        }
        
        // We convert all units to Meters and then we convert from there

        let inputUnitToMeters: Double
        let outputMetersToOutputUnit: Double

        switch currentUnit {
        case "meters":
            inputUnitToMeters = 1.0
        case "kilometers":
            inputUnitToMeters = 1000.0
        case "feet":
            inputUnitToMeters = 0.3048
        case "yard":
            inputUnitToMeters = 0.9144
        case "miles":
            inputUnitToMeters = 1609.34
        default:
            // Handle unexpected unit
            return
        }

        switch convertedUnit {
        case "meters":
            outputMetersToOutputUnit = 1.0
        case "kilometers":
            outputMetersToOutputUnit = 0.001
        case "feet":
            outputMetersToOutputUnit = 3.28084
        case "yard":
            outputMetersToOutputUnit = 1.09361
        case "miles":
            outputMetersToOutputUnit = 0.000621371
        default:
            // Handle unexpected unit
            return
        }

        let result = inputValue * inputUnitToMeters * outputMetersToOutputUnit
        convertedValue = String(format: "%.2f", result)
    }
}

#Preview {
    ContentView()
}
