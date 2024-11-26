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
    
    //MARK: - Init
    init() {
       getCoins()
    }
    
    //MARK: - Methods
    func getCoins() {
        guard let url = URL(string: Constants.ALL_COINS_URL) else { return }
        coinSubscription = NetworkManager.downloadData(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (coins) in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
