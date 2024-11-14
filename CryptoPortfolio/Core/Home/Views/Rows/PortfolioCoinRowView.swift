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
        HStack {
            PortfolioLeftColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 30, alignment: .leading)
            PortfolioCentralColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 30, alignment: .center)
            PortfolioRightColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 30, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

extension PortfolioCoinRowView {
    private var PortfolioLeftColumn: some View {
        HStack {
            CoinImageView(coin: coin)
            Text(coin.symbol.uppercased())
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
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
