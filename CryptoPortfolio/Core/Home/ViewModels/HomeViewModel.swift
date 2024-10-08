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
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Methods
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
