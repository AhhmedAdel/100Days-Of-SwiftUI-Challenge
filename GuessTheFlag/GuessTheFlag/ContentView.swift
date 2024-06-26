//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ahmed Adel on 06/02/2024.
//

import SwiftUI

struct FlagImage: View {
    var text: String
    var rotateAmount: Double
    var opacityAmount: Double
    var scaleAmount: Double

    
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(
                    Double(rotateAmount)
                ),
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
            )
            .opacity(opacityAmount)
            .scaleEffect(scaleAmount)

    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany","Ireland", "Italy", "Poland", "Spain","UK", "US","Nigeria", "Ukraine"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameDuration = 0
    
    // For animation purposes
    @State private var chosenFlag = -1
    @State private var rotateAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                        ], center: .top, startRadius: 200, endRadius: 700)
                            .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    Spacer()
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.black)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.heavy))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            chosenFlag = number
                            flagTapped(number)
                            withAnimation() {
                                rotateAmount += 360
                            }
                            withAnimation(.easeInOut(duration: 1.0)) {
                                opacityAmount -= 0.75
                                scaleAmount -= 0.25
                            }
                        } label: {
                            FlagImage(text: countries[number],
                                      rotateAmount: (chosenFlag == number ? rotateAmount : 0),
                                      opacityAmount: (chosenFlag != number ? opacityAmount : 1),
                                      scaleAmount: (chosenFlag != number ? scaleAmount : 1)
                            )
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score is \(score)")
        }
        
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Restart") {
                gameDuration = 0
                score = 0
                askQuestion()
            }
        } message: {
            Text("You scored \(score) out of 8")
        }
    }
    
    func flagTapped(_ number: Int) {

        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! This is not \(countries[correctAnswer])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        
        withAnimation(.bouncy(duration: 0.9)) {
            opacityAmount = 1
            rotateAmount = 0
            scaleAmount = 1
            
            if gameDuration == 7 {
                gameOver = true
            } else {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
                gameDuration += 1
            }
        }
    }
        
}

#Preview {
    ContentView()
}
