//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Ahmed Adel on 14/03/2024.
//

import Foundation


extension Bundle {
    // that T is a placeholde for whaterver type we're trying to work with
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to find \(file) in the Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode the file from Bundle.")
        }
        
        return loaded
    }
}
