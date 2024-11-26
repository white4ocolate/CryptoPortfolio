//
//  Launch.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 25.11.2024.
//

import SwiftUI

struct Launch: View {
    @State private var rotation: Double = 0
    @State private var isActive = false
    @State private var opacity = 1.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.launchPurple, Color.launchDark]), startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
            ZStack {
                Image("hexogan")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(rotation))
                    .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: rotation)
                    .onAppear {
                        rotation = 360
                    }
                
                Image("letter-c")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
        }
        .opacity(opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                           withAnimation(.easeOut(duration: 0.2)) {
                               opacity = 0.0
                               dismiss()
                           }
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                               isActive = true
                           }
                       }
                }
    }
}

#Preview {
    Launch()
}
