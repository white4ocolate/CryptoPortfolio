//
//  PortfolioView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 22.10.2024.
//

import SwiftUI

struct PortfolioView: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
            
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        SearchBarView(searchText: $vm.searchText)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(vm.allCoins) { coin in
                                    CoinLogoView(coin: coin)
                                        .frame(width: 75)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.theme.purple, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Edit Portfolio")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PortfolioView()
    }
    .environmentObject(HomeViewModel())
}
