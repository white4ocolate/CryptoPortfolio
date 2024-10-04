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
    
    //MARK: - View
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                HomeHeader
                Spacer()
                if isShowPortofolio {
                    PortfolioCoinRowView(coin: DeveloperPreview.instance.coin)
                } else {
                    HomeCoinRowView(coin: DeveloperPreview.instance.coin)
                }
                Spacer()
            }
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
}

#Preview {
    NavigationView {
        HomeView()
    }
}
