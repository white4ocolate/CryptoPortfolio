//
//  SettingsView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 22.11.2024.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    let githubURL = URL(string: "https://github.com/white4ocolate")!
    let coingeckoURL = URL(string: "https://docs.coingecko.com")!
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                List {
                    Section {
                        Toggle("Dark theme", isOn: $isDarkMode)
                            .tint(Color.theme.background)
                    } header: {
                        Text("Settings")
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsView()
}
