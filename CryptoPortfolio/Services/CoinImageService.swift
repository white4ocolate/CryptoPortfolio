//
//  CoinImageService.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 10.10.2024.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    //MARK: - Properties
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    //MARK: - Methods
    init(coin: Coin) {
        self.coin = coin
        self.getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
