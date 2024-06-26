//
//  ContentView.swift
//  BetterRest
//
//  Created by Ahmed Adel on 16/02/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var bedTime = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var compenents = DateComponents()
        compenents.hour = 7
        compenents.minute = 0
        return Calendar.current.date(from: compenents) ?? .now
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp, calculateBedtime)
                }
               
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount, calculateBedtime)
                }
                
                VStack(spacing: 50) {
                    VStack(alignment: .leading, spacing: 0) {
                        Picker("Daily coffe intake", selection: $coffeeAmount) {
                            ForEach(0..<10){Text("\($0)")}
                        }
                        .onChange(of: coffeeAmount, calculateBedtime)
                        .pickerStyle(.automatic)
                    }
                    
                    VStack(alignment: .center) {
                        Text("Your Ideal bedtime 🛌 is \(bedTime) ")
                            .font(.largeTitle.bold())
                            .padding(EdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert){
//                Button("Ok") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let componenets = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (componenets.hour ?? 0) * 60 * 60
            let minute = (componenets.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
            
            // You can use the model for further calculations
        } catch {
           
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
