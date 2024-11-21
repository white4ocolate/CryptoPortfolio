//
//  CoinDetailViewModel.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.11.2024.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published private var coinDetail: CoinDetail? = nil
    @Published var coin: Coin
    @Published var coinDescription: String? = nil
    @Published var homePageURL: String? = nil
    @Published var subredditURL: String? = nil
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Init
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        
        self.addSubscribers()
    }
    
    //MARK: - Methods
    func addSubscribers() {
        coinDetailDataService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink { [weak self] coinData in
                self?.overviewStatistics = coinData.overview
                self?.additionalStatistics = coinData.additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetail
            .sink { [weak self] coinData in
                self?.coinDescription = coinData?.readableDescription
                self?.homePageURL = coinData?.links?.homepage?.first
                self?.subredditURL = coinData?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistic(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overviewData = createOverviewData(coin: coin)
        let additionalData = createAdiitionalData(coinDetail: coinDetail, coin: coin)
        
        return (overviewData, additionalData)
    }
    
    private func createOverviewData(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceStatistic = Statistic(title: "Price",
                                       value: price,
                                       percentageChange: priceChangePercentage)
        
        let markeCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage = coin.marketCapChangePercentage24H
        let marketCapStatistic = Statistic(title: "Market Cap",
                                           value: markeCap,
                                           percentageChange: marketCapChangePercentage)
        
        let rank = "\(coin.rank)"
        let rankStatistic = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStatistic = Statistic(title: "Volume", value: volume)
        
        return [priceStatistic, marketCapStatistic, rankStatistic, volumeStatistic]
    }
    
    private func createAdiitionalData(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStatistic = Statistic(title: "24H High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStatistic = Statistic(title: "24H Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let priceChangePercentage = coin.priceChangePercentage24H
        let priceChangeStatistic = Statistic(title: "24H Price Change",
                                             value: priceChange,
                                             percentageChange: priceChangePercentage)

        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage = coin.marketCapChangePercentage24H
        let marketCapChangeStatistic = Statistic(title: "24H Market Cap Change",
                                                 value: marketCapChange,
                                                 percentageChange: marketCapChangePercentage)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStatistic = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? ""
        let hashingStatistic = Statistic(title: "Hashing Algorithm", value: hashing)
        
        return [highStatistic, lowStatistic, priceChangeStatistic, marketCapChangeStatistic, blockTimeStatistic, hashingStatistic]
    }
}
