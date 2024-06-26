//
//  DetailView.swift
//  Bookworm
//
//  Created by Ahmed Adel on 05/04/2024.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading) {
                Text(book.review)
                    .padding()
                Text(book.date.formatted(.dateTime.day().month().year()))
                    .padding(.bottom)
                    .offset(x: 15)
                    .italic()
                    .foregroundStyle(.black.opacity(0.6))
            }
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        }
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Authoer", genre: "Fantasy", review: "This was a really good book I enjoyed it so much", rating: 4, date: Date.now)
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Book failed to load: \(error.localizedDescription)")
    }
}
