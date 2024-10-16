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
    private let fileManager = LocalFileManager.instance
    private let imageName: String
    
    //MARK: - Methods
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: Constants.COIN_IMAGES) {
            self.image = savedImage
        } else {
            self.downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: Constants.COIN_IMAGES)
                self.imageSubscription?.cancel()
            })
    }
}
