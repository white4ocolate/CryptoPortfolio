//
//  ChangePercentage24hView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import SwiftUI

struct ChangePercentageView: View {
    
    //MARK: - Properties
    var percentage: Double? = 10.63
    
    //MARK: - View
    var body: some View {
        HStack() {
            Image(systemName: (percentage != nil) ? "triangle.fill" : "")
                .resizable()
                .frame(width: 10, height: 10)
                .rotationEffect(
                    Angle(degrees: (percentage ?? 0) >= 0 ?
                          0 : 180))
            Text((percentage?.asPercentString()) ?? "")
                .font(.caption)
        }
        .foregroundStyle((percentage ?? 0) >= 0 ?
                         Color.theme.green : Color.theme.red)
    }
}

#Preview {
    ChangePercentageView()
}
