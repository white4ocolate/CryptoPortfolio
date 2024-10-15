//
//  CoinDataService.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 08.10.2024.
//

import Foundation
import Combine

class CoinDataService {
    
    //MARK: - Properties
    @Published var allCoins: [Coin] = []
    private var coinSubscription: AnyCancellable?
    
    //MARK: - Methods
    init() {
       getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: Constants().allCoinsURL) else { return }
        coinSubscription = NetworkManager.downloadData(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (coins) in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}