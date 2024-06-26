//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ahmed Adel on 28/03/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                    
                    Text("Your total Cost is \(order.cost, format: .currency(code: "USD"))")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Button("Place Order") {
                        Task {
                            await placeOrder()
                        }
                    }
                        .padding()
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") { }
            } message: {
                Text(confirmationMessage)
            }
            .alert(errorMessage, isPresented: $showingError) { }
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errorMessage = "Checkout failed: \(error.localizedDescription)"
            showingError = true
        }
        
        

    }
}

#Preview {
    CheckoutView(order: Order())
}
