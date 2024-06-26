//
//  ContentView.swift
//  WordScamble
//
//  Created by Ahmed Adel on 22/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)

                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button ("New Word") { startGame() }
                }
            }
        }
        .onSubmit(addNewWord)
        .onAppear() {
            startGame()
        }
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        
        
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "you can't spell that word out of \(rootWord)")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "word not recoginzed", message: "you can't just make them up, you know ;)")
            return
        }
        
        guard isShort(word: answer) else {
            wordError(title: "Short Word", message: "you can't make 2 letters word in the game")
            return
        }
        
        guard isFirstThreeLetters(word: answer) else {
            wordError(title: "That's so easy", message: "you can't just select the first 3 letters, work harder!")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }

        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isShort(word: String) -> Bool {
        !(word.count < 3)
    }
    
    func isFirstThreeLetters(word: String) -> Bool {
        let rootPrefix = rootWord.prefix(3).lowercased()
        return word != rootPrefix
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
