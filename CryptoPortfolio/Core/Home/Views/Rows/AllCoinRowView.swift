//
//  AllCoinRowView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.10.2024.
//

import SwiftUI

struct AllCoinRowView: View {
    
    //MARK: - properties
    let coin: Coin
    
    //MARK: - View
    var body: some View {
        HStack(spacing: 10) {
            AllLeftColumn
            
            Spacer()
            
            AllCentralColumn
            
            Spacer()
            
            AllRightColumn
        }
        .padding(.horizontal, 10)
    }
}

extension AllCoinRowView {
    private var AllLeftColumn: some View {
        Group {
            Text("\(coin.rank ?? 0)")
//                .font(.headline)
                .font(.subheadline)
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
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
                Text((coin.marketCap ?? 0).formattedWithAbbreviations())
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
    
    private var AllCentralColumn: some View {
        Text(coin.currentPrice.asCurrencyWith6Decimals())
            .bold()
            .font(.subheadline)
            .foregroundStyle(Color.theme.accent)
    }
    
    private var AllRightColumn: some View {
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
                    .font(.subheadline)
            }
        }
        .foregroundStyle((coin.athChangePercentage ?? 0) >= 0 ?
                         Color.theme.green : Color.theme.red)
    }
}


#Preview {
    AllCoinRowView(coin: DeveloperPreview.instance.coin)
}
