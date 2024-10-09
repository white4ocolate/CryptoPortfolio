//
//  PriceView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI

struct PriceView: View {
    
    //MARK: - Properties
    var price: String
    
    //MARK: - View
    var body: some View {
        Text(price)
            .bold()
            .font(.subheadline)
            .foregroundStyle(Color.theme.accent)
    }
}

#Preview {
    PriceView(price: "100.00")
}
