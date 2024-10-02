//
//  CircleButtonView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 02.10.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    //MARK: - Properties
    let iconName: String
    
    //MARK: - View
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10,
                    x: 0,
                    y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "plus")
        CircleButtonView(iconName: "info")
            .colorScheme(.dark)
    }
}
