//
//  MarketDataService.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 21.10.2024.
//

import Foundation
import Combine

class MarketDataService {
    
    //MARK: - Properties
    @Published var marketData: MarketData? = nil
    private var marketDataSubscription: AnyCancellable?
    
    //MARK: - Init
    init() {
       getData()
    }
    
    //MARK: - Methods
    func getData() {
        guard let url = URL(string: Constants.MARKET_DATA_URL) else { return }
        marketDataSubscription = NetworkManager.downloadData(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.marketData = returnedData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

