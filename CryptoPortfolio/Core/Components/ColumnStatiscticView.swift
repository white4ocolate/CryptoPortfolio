//
//  StatiscticView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.10.2024.
//

import SwiftUI

struct ColumnStatiscticView: View {
    //MARK: - Properties
    let statistic: Statistic
    
    //MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            if ((statistic.value?.isEmpty) != nil) {
                Text(statistic.value ?? "")
                    .bold()
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.accent)
            }
            if statistic.percentageChange != nil {
                ChangePercentageView(percentage: statistic.percentageChange)
            }
        }
    }
}

#Preview {
    ColumnStatiscticView(statistic: DeveloperPreview.instance.statisticMC)
    ColumnStatiscticView(statistic: DeveloperPreview.instance.statisticVl)
    ColumnStatiscticView(statistic: DeveloperPreview.instance.statisticDom)
}
