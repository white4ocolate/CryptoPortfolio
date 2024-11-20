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
    @StateObject private var portfolioVM: PortfolioViewModel
    
    //MARK: - Init
    init(homeVM: HomeViewModel) {
        _portfolioVM = StateObject(wrappedValue: PortfolioViewModel(homeVM: homeVM))
    }
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        SearchBarView(searchText: $portfolioVM.searchText)
                        CoinLogoList
                        if portfolioVM.selectedCoin != nil {
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
                .onChange(of: portfolioVM.searchText) { newValue in
                    if newValue == "" {
                        portfolioVM.removeSelectedCoin()
                    }
                }
            }
            .background(Color.theme.background).ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationView {
        PortfolioView(homeVM: HomeViewModel())
    }
}

extension PortfolioView {
    private var CoinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(portfolioVM.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 80)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.background)
                                .shadow(color: Color.theme.accent.opacity(0.25), radius: 4, x: 0, y: 0)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(portfolioVM.selectedCoin?.id == coin.id ? Color.theme.accent
                                                : Color.theme.background, lineWidth: 1)
                                })
                        )
                        .onTapGesture {
                            withAnimation {
                                portfolioVM.selectCoin(coin)
                            }
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var PortfolioSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(portfolioVM.selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(portfolioVM.selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount:")
                TextField("Ex: 10.5", text: $portfolioVM.amountText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(portfolioVM.currentValue.asCurrencyWith2Decimals())
            }
            Button {
                withAnimation {
                    portfolioVM.saveButtonPressed()
                    hideKeyboard()
                }
            } label: {
                Text("Save".uppercased())
                    .font(.title2)
                    .foregroundStyle(Color.theme.accent)
                    .opacity(portfolioVM.amountText.isEmpty ? 0.25 : 1)
                    .frame(width: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.background)
                            .shadow(color: Color.theme.accent.opacity(0.25),
                                    radius: 4,
                                    x: 0,
                                    y: 0)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(portfolioVM.amountText.isEmpty ? Color.theme.background
                                            : Color.theme.accent, lineWidth: 3)
                            })
                    )
            }
            .disabled(portfolioVM.amountText.isEmpty ? true : false)
        }
        .padding()
        .animation(.none, value: portfolioVM.selectedCoin?.id)
        .font(.headline)
    }
}
