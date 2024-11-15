//
//  DetailView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 15.11.2024.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Properties
    @Binding var coin: Coin?
    
    init(coin: Binding<Coin?> ) {
        self._coin = coin
        print("Initializing coin \(coin.wrappedValue?.name)")
    }
    
    //MARK: - View
    var body: some View {
        Text(coin?.name ?? "")
    }
}

#Preview {
    DetailView(coin: .constant(DeveloperPreview.instance.coin))
}
