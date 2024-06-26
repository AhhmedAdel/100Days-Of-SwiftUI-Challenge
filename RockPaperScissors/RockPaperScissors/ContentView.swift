import SwiftUI

struct ContentView: View {
    let moves = ["Rock 🪨", "Paper 📄", "Scissors ✂️"]
    let winningMoves = ["Paper 📄", "Scissors ✂️", "Rock 🪨"]
    @State private var playerMove = ""
    @State private var botMove = ""
    @State private var result = ""
    @State private var round = 0
    @State private var score = 0
    @State private var botScore = 0
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Text("Select your move")
                        .font(.title.bold())
                    ForEach(moves, id: \.self) { move in
                        Button(action: {
                            self.playerMove = move
                            self.botMove = self.moves[Int.random(in: 0...2)]
                            self.result = determineWinner()
                        }, label: {
                            Text(move)
                                .font(.title)
                                .padding()
                                .frame(width: 250)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                    Text(result)
                        .font(.largeTitle.bold())
                        .padding()
                    if !playerMove.isEmpty {
                        Text("The Bot move was \(botMove)")
                            .font(.title2)
                    }
                    HStack(spacing: 40) {
                        Text("You: \(score)")
                            .padding()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("Bot: \(botScore)")
                            .padding()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                    }
                }
                .alert("Game Over", isPresented: $isGameOver) {
                    Button("Play Again", role: .cancel) {
                        round = 0
                        score = 0
                        botScore = 0
                        result = ""
                        isGameOver = false
                    }
                }
            }
            .navigationTitle("Rock, Paper, Scissors")
        }
        .padding()
    }

    func determineWinner() -> String {
        while round < 5 {
            if playerMove == botMove {
                return "Draw"
            } else if (playerMove == "Rock 🪨" && botMove == "Paper 📄") ||
                        (playerMove == "Paper 📄" && botMove == "Rock 🪨") ||
                        (playerMove == "Scissors ✂️" && botMove == "Paper 📄") {
                score += 1
                round += 1
                return "You Won"
            } else {
                round += 1
                botScore += 1
                return "You Lost"
            }
        }
        isGameOver.toggle()
        return "Game Over"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
