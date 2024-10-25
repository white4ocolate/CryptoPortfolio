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
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var selecetedCoin: Coin? = nil
    @State private var amountText: String = ""
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
            
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        SearchBarView(searchText: $homeVM.searchText)
                        CoinLogoList
                        if selecetedCoin != nil {
                            PortfolioSection
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

extension PortfolioView {
    private var CoinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(homeVM.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 80)
                        .padding(15)
                        .onTapGesture {
                            withAnimation {
                                selecetedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.background)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selecetedCoin?.id == coin.id ? Color.theme.accent : Color.theme.background, lineWidth: 1)
                                })
                        )
                        .shadow(color: Color.theme.accent.opacity(0.25),
                                radius: 4,
                                x: 0,
                                y: 0)
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var PortfolioSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selecetedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selecetedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount:")
                TextField("Ex: 10.5", text: $amountText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .font(.title2)
                    .foregroundStyle(Color.theme.accent)
                    .opacity(amountText.isEmpty ? 0.25 : 1)
                    .frame(width: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.background)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(amountText.isEmpty ? Color.theme.background : Color.theme.accent, lineWidth: 1)
                            })
                    )
                    .shadow(color: Color.theme.accent.opacity(0.25),
                            radius: 4,
                            x: 0,
                            y: 0)
            }
            .disabled(amountText.isEmpty ? true : false)
        }
        .padding()
        .animation(.none)
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let amount = Double(amountText) {
            return amount * (selecetedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selecetedCoin else { return }
        withAnimation {
            removeSelectedCoin()
        }
        hideKeyboard()
    }
    
    private func removeSelectedCoin() {
        selecetedCoin = nil
        homeVM.searchText = ""
    }
}
