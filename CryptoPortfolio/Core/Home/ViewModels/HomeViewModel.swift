//
//  HomeViewModel.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 07.10.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    //MARK: - Methods
    init() {
        //Simulation fetching data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
