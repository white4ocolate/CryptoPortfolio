//
//  HomeView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 02.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - properties
    @State private var isShowPortfolio: Bool = false
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolioView: Bool = false
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView(homeVM: vm)
                        .environmentObject(vm)
                }
            VStack {
                HomeHeader
                StatisticView(isShowPortfolio: $isShowPortfolio)
                SearchBarView(searchText: $vm.searchText)
                ColumnTitles
                Group {
                    if isShowPortfolio {
                        PortfolioCoinsList
                    } else {
                        AllCoinsList
                    }
                }.refreshable {
                    withAnimation {
                        vm.reloadData()
                    }
                }
                Spacer()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension HomeView {
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(iconName: isShowPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(isAnimate: $isShowPortfolio)
                )
                .onTapGesture {
                    if isShowPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            Spacer()
            Text(isShowPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        isShowPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var PortfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                PortfolioCoinRowView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .trailing))
    }
    
    private var AllCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                AllCoinRowView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }
    
    private var ColumnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
            Spacer()
            Text(isShowPortfolio ? "Value" : "24h %")
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environmentObject(HomeViewModel())
}
