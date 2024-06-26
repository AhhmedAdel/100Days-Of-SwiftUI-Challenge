//
//  LineSeperator.swift
//  Moonshot
//
//  Created by Ahmed Adel on 15/03/2024.
//

import SwiftUI

struct LineSeperator: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    LineSeperator()
}
