//
//  ContentView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 01.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                
                Text("Secondary Text")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("Red Text")
                    .foregroundStyle(Color.theme.red)
                
                Text("Green Text")
                    .foregroundStyle(Color.theme.green)
            }
        }
    }
}

#Preview {
    ContentView()
}
