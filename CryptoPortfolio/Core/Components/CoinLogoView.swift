//
//  CoinLogoView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 23.10.2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    //MARK: - Properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                CoinImageView(coin: coin)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
