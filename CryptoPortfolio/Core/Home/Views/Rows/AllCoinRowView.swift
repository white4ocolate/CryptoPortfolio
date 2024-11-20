//
//  AllCoinRowView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.10.2024.
//

import SwiftUI

struct AllCoinRowView: View {
    
    //MARK: - Properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        HStack() {
            AllLeftColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 43, alignment: .leading)
            AllCentralColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 25, alignment: .trailing)
            AllRightColumn
                .frame(width: ((UIScreen.current?.bounds.width)! / 100) * 22, alignment: .trailing)
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

extension AllCoinRowView {
    private var AllLeftColumn: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.subheadline)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 20, alignment: .leading)
            CoinImageView(coin: coin)
            VStack(alignment: .leading) {
                CoinNameView(name: coin.symbol.uppercased())
                Text((coin.marketCap ?? 0).formattedWithAbbreviations())
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
    
    private var AllCentralColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            PriceView(price: coin.currentPrice.asCurrencyWith6Decimals())
            HStack(spacing: 2) {
                Text((coin.athChangePercentage?.asPercentString()) ?? "")
                Text("ATH")
            }
            .font(.caption)
            .foregroundStyle(Color.theme.secondaryText)
        }
    }
    
    private var AllRightColumn: some View {
        VStack(alignment: .trailing) {
            //            Image(systemName: "chart.xyaxis.line")
            //                .resizable()
            //                .frame(width: 80, height: 20)
            ChangePercentageView(percentage: coin.priceChangePercentage24H)
        }
        .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ?
                         Color.theme.green : Color.theme.red)
    }
}


#Preview {
    AllCoinRowView(coin: DeveloperPreview.instance.coin)
}
