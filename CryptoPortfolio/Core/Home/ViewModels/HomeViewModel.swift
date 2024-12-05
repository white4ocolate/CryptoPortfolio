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
    @Published var statistics: [Statistic] = []
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .rank
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    enum SortOption {
        case rank, rankReversed, price, priceReversed, change24H, change24HReversed
    }
    
    //MARK: - Init
    init() {
        self.addSubscribers()
    }
    
    //MARK: - Methods
    func addSubscribers() {
        //update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        //update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func removeCoin(at offsets: IndexSet) {
        print(">>>DEBUG: \(portfolioCoins)")
        for index in offsets {
            let coin = portfolioCoins[index]
            portfolioCoins.remove(at: index)
            deleteCoinFromCoreData(coin)
        }
    }
    private func deleteCoinFromCoreData(_ coin: Coin) {
        portfolioDataService.updatePortfolio(coin: coin, amount: 0)
    }
    
    private func mapPortfolioCoins(allCoins: [Coin], portfolioCoins: [Portfolio]) -> [Coin] {
        allCoins
            .compactMap { (coin) -> Coin? in
                guard let entity = portfolioCoins.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
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
    
    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sort: sort)
        return updatedCoins
    }
    
    private func sortCoins(coins: inout [Coin], sort: SortOption) {
        switch sort {
        case .rank:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .change24H:
            coins.sort(by: { $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0 })
        case .change24HReversed:
            coins.sort(by: { $0.priceChangePercentage24H ?? 0 < $1.priceChangePercentage24H ?? 0 })
        }
    }
    
    private func mapMarketData(data: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = data else { return stats }
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "Volume", value: data.volume)
        let dominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue =
        portfolioCoins
            .map({ $0.currentHoldingsValue }).reduce(0, + )
        
        let portfolioPreviousValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentageChange)
                return previousValue
            }
            .reduce(0, + )
        
        let portfolioPercentageChange = ((portfolioValue - portfolioPreviousValue) / portfolioPreviousValue) * 100
        
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: portfolioPercentageChange)
        stats.append(contentsOf: [marketCap, volume, dominance, portfolio])
        
        return stats
    }
}
