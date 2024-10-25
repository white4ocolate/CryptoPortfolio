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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    //MARK: - Views
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
