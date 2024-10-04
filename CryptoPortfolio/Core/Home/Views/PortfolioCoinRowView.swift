//
//  PortfolioCoinRowView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.10.2024.
//

import SwiftUI

struct PortfolioCoinRowView: View {
    
    //MARK: - properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: coin.image)) { $0.resizable() }
            placeholder: {
                Color.theme.secondaryText
            }
            .frame(width: 27, height: 27)
            .clipShape(.rect(cornerRadius: 27))
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.theme.secondaryText)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                HStack() {
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .rotationEffect(
                            Angle(degrees: (coin.athChangePercentage ?? 0) >= 0 ?
                            0 : 180))
                    Text((coin.athChangePercentage?.asPercentString()) ?? "")
                }
                .foregroundStyle((coin.athChangePercentage ?? 0) >= 0 ?
                                 Color.theme.green : Color.theme.red)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                HStack {
                    Text("\((coin.currentHoldings ?? 0).asNumberString())")
                    Text(coin.symbol.uppercased())
                }
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    PortfolioCoinRowView(coin: DeveloperPreview.instance.coin)
}
