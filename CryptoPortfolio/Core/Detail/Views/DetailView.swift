//
//  DetailView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 15.11.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    //MARK: - Properties
    @StateObject private var vm: CoinDetailViewModel
    @State private var isShowPortfolio: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing: CGFloat = 30
    
    //MARK: - Init
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initializing coin \(coin.name)")
    }
    
    //MARK: - View
    var body: some View {
        ScrollView {
            VStack {
                Title
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                OverviewTitle
                Divider()
                OverviewInfo
                
                AdditionalTitle
                Divider()
                AdditionalInfo
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    CoinImageView(coin: vm.coin)
                        .frame(width: 25, height: 25)
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundStyle(Color.theme.secondaryText)
                }
            }
        }
    }
}

extension DetailView {
    private var Title: some View {
        setTitle(text: vm.coin.name)
    }
    private var OverviewTitle: some View {
        setTitle(text: "Overview")
    }
    
    private var AdditionalTitle: some View {
        setTitle(text: "Additional Details")
    }
    
    private func setTitle(text: String) -> some View {
        return Text(text)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var OverviewInfo: some View {
        setStatistic(info: vm.overviewStatistics)
    }
    
    private var AdditionalInfo: some View {
        setStatistic(info: vm.additionalStatistics)
    }
    
    private func setStatistic(info: [Statistic]) -> some View {
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(info) { statistic in
                ColumnStatiscticView(statistic: statistic)
            }
        }
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
        .environmentObject(DeveloperPreview.instance.homeVM)
}
