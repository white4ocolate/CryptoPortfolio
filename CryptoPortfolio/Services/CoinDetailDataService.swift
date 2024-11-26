//
//  CoinDetailDataService.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.11.2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    //MARK: - Properties
    @Published var coinDetail: CoinDetail? = nil
    private var coinSubscription: AnyCancellable?
    var coin: Coin
    
    //MARK: - Init
    init(coin: Coin) {
        self.coin = coin
        getCoinDetail()
    }
    
    //MARK: - Methods
    func getCoinDetail() {
        guard let url = URL(string: Constants.coinDetailURL(for: coin.id)) else { return }
        coinSubscription = NetworkManager.downloadData(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (coinDetail) in
                self?.coinDetail = coinDetail
                self?.coinSubscription?.cancel()
            })
    }
}
