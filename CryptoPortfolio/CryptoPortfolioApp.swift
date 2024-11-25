//
//  CryptoPortfolioApp.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 01.10.2024.
//

import SwiftUI

@main
struct CryptoPortfolioApp: App {
    
    //MARK: - Properties
    @StateObject private var vm = HomeViewModel()
    
    //MARK: - Init
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    //MARK: - Views
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
            .environmentObject(vm)
        }
    }
}
