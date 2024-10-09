//
//  CirlceCoinImage.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI

struct CirlceCoinImageView: View {
    
    //MARK: - Properties
    var imageURL: String
    
    //MARK: - View
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { $0.resizable() }
        placeholder: {
            Image(systemName: "coloncurrencysign.circle")
                .resizable()
        }
        .frame(width: 30, height: 30)
        .clipShape(.rect(cornerRadius: 30))
    }
}

#Preview {
    CirlceCoinImageView(imageURL: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628")
}
