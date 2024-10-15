//
//  PortfolioCoinRowView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.10.2024.
//

import SwiftUI

struct PortfolioCoinRowView: View {
    
    //MARK: - Properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        HStack(spacing: 10) {
            PortfolioLeftColumn
            Spacer()
            PortfolioCentralColumn
            Spacer()
            PortfolioRightColumn
        }
        .padding(.horizontal, 10)
    }
}

extension PortfolioCoinRowView {
    private var PortfolioLeftColumn: some View {
        Group{
            CoinImageView(coin: coin)
//            CirlceCoinImageView(imageURL: coin.image)
            VStack(alignment: .leading) {
                CoinNameView(name: coin.name)
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
    
    private var PortfolioCentralColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            PriceView(price: coin.currentPrice.asCurrencyWith6Decimals())
            ChangePercentageView(percentage: coin.priceChangePercentage24H)
        }
    }
    
    private var PortfolioRightColumn: some View {
        VStack(alignment: .trailing) {
            PriceView(price: coin.currentHoldingsValue.asCurrencyWith2Decimals())
            HStack {
                Text("\((coin.currentHoldings ?? 0).asNumberString())")
                Text(coin.symbol.uppercased())
            }
            .font(.caption)
            .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

#Preview {
    PortfolioCoinRowView(coin: DeveloperPreview.instance.coin)
}
