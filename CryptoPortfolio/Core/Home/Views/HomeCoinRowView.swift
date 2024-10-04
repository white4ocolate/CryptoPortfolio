//
//  HomeCoinRowView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.10.2024.
//

import SwiftUI

struct HomeCoinRowView: View {
    
    //MARK: - properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        HStack(spacing: 10) {
            Text("\(coin.rank ?? 0)")
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 25)
            
            AsyncImage(url: URL(string: coin.image)) { $0.resizable() }
            placeholder: {
                Color.theme.secondaryText
            }
            .frame(width: 27, height: 27)
            .clipShape(.rect(cornerRadius: 27))
            
            VStack(alignment: .leading) {
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
                Text((coin.marketCap ?? 0).formattedWithAbbreviations())
                    .font(.headline)
                    .foregroundStyle(Color.theme.secondaryText)
            }
            
            Spacer()
            
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Image(systemName: "chart.xyaxis.line")
                    .resizable()
                    .frame(width: 80, height: 20)
                HStack {
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .rotationEffect(
                            Angle(degrees: (coin.athChangePercentage ?? 0) >= 0 ?
                            0 : 180))
                    Text((coin.athChangePercentage?.asPercentString()) ?? "")
                }
            }
            .foregroundStyle((coin.athChangePercentage ?? 0) >= 0 ?
                             Color.theme.green : Color.theme.red)
        }
    }
}



#Preview {
    HomeCoinRowView(coin: DeveloperPreview.instance.coin)
}
