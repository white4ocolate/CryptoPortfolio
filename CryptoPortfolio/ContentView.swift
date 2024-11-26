//
//  ContentView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 01.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @StateObject private var vm = HomeViewModel()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var showLaunchScreenView: Bool = true
    
    //MARK: - Init
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
            .environmentObject(vm)
            .overlay(Launch())
        }
    }
}

#Preview {
    ContentView()
}
