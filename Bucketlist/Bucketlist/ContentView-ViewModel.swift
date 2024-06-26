//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Ahmed Adel on 23/04/2024.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        
        var showAuthErrorAlert = false
        var authErrorMessage = ""
        
        //
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("unable to save data")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Please authenticate yourself to unlock your places.."
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                    sucess, localizedError in
                    if sucess {
                        self.isUnlocked = true
                    } else {
//                        self.showAuthErrorAlert = true
//                        self.authErrorMessage = "Please try again."
                    }
                }
            } else {
//                self.showAuthErrorAlert = true
//                self.authErrorMessage = "No biometrics"
//                self.isUnlocked = true
            }
        }
    }
}

