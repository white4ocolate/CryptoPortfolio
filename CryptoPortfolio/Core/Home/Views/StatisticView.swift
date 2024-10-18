//
//  HomeStatisticView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.10.2024.
//

import SwiftUI

struct StatisticView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isShowPortfolio: Bool
    
    //MARK: - View
    var body: some View {
        HStack(alignment: .top) {
            ForEach(vm.statistics) { statistic in
                ColumnStatiscticView(statistic: statistic)
                    .frame(width: (UIScreen.current?.bounds.width)! / 3)
            }
        }
        .frame(width: UIScreen.current?.bounds.width, alignment: isShowPortfolio ? .trailing : .leading)
    }
}

#Preview {
    StatisticView(isShowPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
