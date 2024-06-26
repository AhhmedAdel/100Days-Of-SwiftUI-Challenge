//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ahmed Adel on 02/04/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let date = Date.now
    // Validation if the user left Textfields empty
    var isTitleAuthorEmpty: Bool {
        
        if title.trimmingCharacters(in: .whitespaces).isEmpty
            || author.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        return false
    }
    
    let genres = ["Fantasy" , "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: date)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    // User can't proceed if Textfields are empty 
                    .disabled(isTitleAuthorEmpty == true)
                }
            }
            .navigationTitle("Add book")
        }
    }
}

#Preview {
    AddBookView()
}
