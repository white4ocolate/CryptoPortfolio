//
//  HomeViewModel.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 07.10.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = [
        Statistic(title: "Market Cap", value: "2,33 $ T", percentageChange: 13.52),
        Statistic(title: "Volume", value: "77,39 $ B", percentageChange: -0.55),
        Statistic(title: "Dominance", value: "57,39 %"),
        Statistic(title: "Total Value", value: "3562,49 $"),
        Statistic(title: "Change", value: "+142 $",percentageChange: 12.78),
        Statistic(title: "Dominance", value: "57,39 %")
    ]
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Methods
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
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
