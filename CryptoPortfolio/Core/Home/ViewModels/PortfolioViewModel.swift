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
        self.selectedCoin = coin
    }
    
    func saveButtonPressed() {
        guard self.selectedCoin != nil else { return }
        removeSelectedCoin()
    }
    
    func removeSelectedCoin() {
        self.selectedCoin = nil
        searchText = ""
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
