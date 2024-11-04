//
//  PortfolioViewModel.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 25.10.2024.
//

import Foundation
import Combine

class PortfolioViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var selectedCoin: Coin? = nil
    @Published var allCoins: [Coin] = []
    @Published var amountText: String = ""
    @Published var searchText: String = ""
    @Published private(set) var currentValue: Double = 0
    
    private let homeVM: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        addSubscribers()
    }
    
    //MARK: - Methods
    func selectCoin(_ coin: Coin) {
        selectedCoin = coin
        guard selectedCoin != nil else { return }
        self.updateSelectedCoin(coin: selectedCoin!)
    }
    
    func saveButtonPressed() {
        guard self.amountText != "",
              let amount = Double(self.amountText),
              self.selectedCoin != nil else { return }
        homeVM.updatePortfolio(coin: self.selectedCoin!, amount: amount)
        removeSelectedCoin()
        HapticManager.notification(type: .success)
    }
    
    func removeSelectedCoin() {
        self.selectedCoin = nil
        searchText = ""
    }
    
    private func updateSelectedCoin(coin: Coin) {
        if let portfolioCoin = homeVM.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            amountText = "\(amount)"
        } else {
            amountText = "" 
        }
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(homeVM.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        $amountText
            .combineLatest($selectedCoin)
            .map { [weak self] (amountText, selectedCoin) -> Double in
                guard let self = self, let amount = Double(amountText) else { return 0 }
                return amount * (selectedCoin?.currentPrice ?? 0)
            }
            .assign(to: &$currentValue)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased().trimmingCharacters(in: .whitespaces)
        return coins.filter {
            $0.name.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.id.lowercased().contains(lowercasedText)
        }
    }
}
