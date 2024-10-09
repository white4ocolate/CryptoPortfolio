//
//  CoinInfoView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI

struct CoinNameView: View {
    
    //MARK: - Properties
    var name: String
    
    //MARK: - View
    var body: some View {
        Text(name)
            .bold()
            .font(.subheadline)
            .foregroundStyle(Color.theme.accent)
    }
}

#Preview {
    CoinNameView(name: "Bitcoin")
}
