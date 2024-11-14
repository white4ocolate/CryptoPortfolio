//
//  HomeView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 02.10.2024.
//

import SwiftUI
import Combine

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
                    .padding(.vertical, 5)
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
                    .padding(.vertical, 5)
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }
    
    private var ColumnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .frame(width: isShowPortfolio ?
                   ((UIScreen.current?.bounds.width)! / 100) * 30 :
                    ((UIScreen.current?.bounds.width)! / 100) * 43,
                   alignment: .leading)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
                
            }
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: isShowPortfolio ?
                   ((UIScreen.current?.bounds.width)! / 100) * 30 :
                    ((UIScreen.current?.bounds.width)! / 100) * 25,
                   alignment: isShowPortfolio ? .center : .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            HStack {
                Text(isShowPortfolio ? "Value" : "24h %")
                if !isShowPortfolio {
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .change24H || vm.sortOption == .change24HReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .change24H ? 0 : 180))
                }
            }
            .frame(width: isShowPortfolio ?
                   ((UIScreen.current?.bounds.width)! / 100) * 30 :
                    ((UIScreen.current?.bounds.width)! / 100) * 22,
                   alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    !isShowPortfolio ? vm.sortOption = vm.sortOption == .change24H ? .change24HReversed : .change24H : nil
                }
            }
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
