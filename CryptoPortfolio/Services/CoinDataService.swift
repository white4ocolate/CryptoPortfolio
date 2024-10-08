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
    var coinSubscription: AnyCancellable?
    
    //MARK: - Methods
    init() {
       getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCoins)  in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
