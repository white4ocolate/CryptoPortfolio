//
//  DetailView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 15.11.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    //MARK: - Properties
    @Binding var coin: Coin?
    
    //MARK: - View
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
    @State private var showFullDescription: Bool = false
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
        ZStack {
            Color.theme.background.ignoresSafeArea()
            ScrollView {
                VStack {
                    Title
                    ChartView(coin: vm.coin)
                        .padding(.vertical)
                    
                    OverviewTitle
                    Description
                    OverviewInfo
                    Divider()
                    
                    AdditionalTitle
                    AdditionalInfo
                    Divider()
                    
                    LinksTitle
                    LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
                        WebSite
                        SubredditURL
                    }
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
                            .foregroundStyle(Color.theme.accent)
                    }
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
    
    private var LinksTitle: some View {
        setTitle(text: "Links")
    }
    
    private var OverviewInfo: some View {
        setStatistic(info: vm.overviewStatistics)
    }
    
    private var AdditionalInfo: some View {
        setStatistic(info: vm.additionalStatistics)
    }
    
    private var Description: some View {
        VStack(alignment: .leading) {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                Text(coinDescription)
                    .lineLimit(!showFullDescription ? 4 : nil)
                    .font(.callout)
                    .foregroundStyle(Color.theme.secondaryText )
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            showFullDescription.toggle()
                        }
                    } label: {
                        HStack {
                            Image(systemName: !showFullDescription ? "chevron.down" : "chevron.up")
                            Text(!showFullDescription ? "Show more" : "Show less")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                        }
                    }
                    .tint(.blue)
                }
            }
        }
    }
    
    private var WebSite: some View {
        HStack {
            if let homePageURL = vm.homePageURL,
               let url = URL(string: homePageURL) {
                let image = Image(systemName: "globe")
                    .resizable()
                    .frame(width: 22, height: 22)
                setLink(title: "Website", url: url, image: image)
            }
        }
    }
    
    private var SubredditURL: some View {
        HStack {
            if let subredditURL = vm.subredditURL,
               let url = URL(string: subredditURL) {
                let redditLogo = Image("reddit")
                    .resizable()
                    .frame(width: 22, height: 22)
                setLink(title: "Reddit", url: url, image:redditLogo)
            }
        }
    }
    
    private func setTitle(text: String) -> some View {
        return Text(text)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func setStatistic(info: [Statistic]) -> some View {
        return LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
            ForEach(info) { statistic in
                ColumnStatiscticView(statistic: statistic)
            }
        }
    }
    
    private func setLink(title: String, url: URL, image: some View) -> some View {
        return HStack {
            image
            Link(title, destination: url)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: 10,
                        x: 0,
                        y: 0)
        )
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
        .environmentObject(DeveloperPreview.instance.homeVM)
}
