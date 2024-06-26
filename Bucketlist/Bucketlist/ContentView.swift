//
//  ContentView.swift
//  Bucketlist
//
//  Created by Ahmed Adel on 21/04/2024.
//
import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    @State private var viewModel = ViewModel()
    @State private var isMapStyleHybrid = false
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                            
                        }
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .mapStyle(isMapStyleHybrid ? .hybrid : .standard)
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
//                    .alert(isPresented: $viewModel.showAuthErrorAlert) {
//                        Alert(title: Text(viewModel.authErrorMessage), dismissButton: .default(Text("OK")))
//                    }
                }
                HStack {
                    Button("Change Map Style") {
                        isMapStyleHybrid.toggle()
                    }
                    .padding()
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundColor(.white)
                    .background(.green)
                }
                .padding(.bottom)
            }
        } else {
            // Button here
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
