//
//  CirlceCoinImage.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI
import Kingfisher

struct CirlceCoinImageView: View {
    
    //MARK: - Properties
    var imageURL: String
    
    //MARK: - View
    var body: some View {
        KFImage(URL(string: imageURL))
                    .resizable()
                    .placeholder {
                        Image(systemName: "coloncurrencysign.circle")
                            .resizable()
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
//        AsyncImage(url: URL(string: imageURL)) { $0.resizable() }
//        placeholder: {
//            Image(systemName: "coloncurrencysign.circle")
//                .resizable()
//        }
//        .frame(width: 30, height: 30)
//        .clipShape(.rect(cornerRadius: 30))
    }
}

#Preview {
    CirlceCoinImageView(imageURL: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628")
}
