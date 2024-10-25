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
    @Published var amountText: String = ""
    @Published var searchText: String = ""
    @Published private(set) var currentValue: Double = 0
    
    private let homeVM: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        addSubscribers()
    }
    
    var allCoins: [Coin] {
        homeVM.allCoins
    }
    
    //MARK: - Methods
    func selectCoin(_ coin: Coin) {
        selectedCoin = coin
    }
    
    func saveButtonPressed() {
        guard selectedCoin != nil else { return }
        removeSelectedCoin()
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        searchText = ""
    }
    
    private func addSubscribers() {
        $amountText
            .combineLatest($selectedCoin)
            .map { [weak self] (amountText, selectedCoin) -> Double in
                guard let self = self, let amount = Double(amountText) else { return 0 }
                return amount * (selectedCoin?.currentPrice ?? 0)
            }
            .assign(to: &$currentValue)
        $searchText
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .sink { [weak self] updatedText in
                self?.homeVM.searchText = updatedText
            }
            .store(in: &cancellables)
    }
}
