//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Ahmed Adel on 16/05/2024.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetails(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetails(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                
                VStack {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                        }
                    }
                    .padding(.vertical)
                    

                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ResortView(resort: .example)
}
