//
//  CoinImageView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI

struct CoinImageView: View {
    
    //MARK: - Properties
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    //MARK: - View
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "coloncurrencysign.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
}
