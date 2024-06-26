//
//  Location.swift
//  Bucketlist
//
//  Created by Ahmed Adel on 22/04/2024.
//
import MapKit
import Foundation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Making an example to showcase how it looks in Previw
    // if DEBUG & endif means that will not be published in the Appstore version of this app
    #if DEBUG
    static let example = Location(id: UUID(), name: "Backingahm Palace", description: "Lit by over 40,000 lightbulbs", latitude: 51.501, longitude: -0.141)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
