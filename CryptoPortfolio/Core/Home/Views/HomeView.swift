//
//  HomeView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 02.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - properties
    @State private var isShowPortofolio: Bool = false
    @EnvironmentObject private var vm: HomeViewModel
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                HomeHeader
                SearchBarView(searchText: $vm.searchText)
                ColumnTitles
                if isShowPortofolio {
                    PortfolioCoinsList
                } else {
                    AllCoinsList
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
            CircleButtonView(iconName: isShowPortofolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(isAnimate: $isShowPortofolio)
                )
            Spacer()
            Text(isShowPortofolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: isShowPortofolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        isShowPortofolio.toggle()
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
            Text(isShowPortofolio ? "Value" : "24h %")
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
