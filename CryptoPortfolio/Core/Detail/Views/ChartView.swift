//
//  ChartView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 20.11.2024.
//

import SwiftUI

struct ChartView: View {
    
    //MARK: - Properties
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    private let lineColor: Color
    private let avaragePrice: Double
    private let startDate: Date
    private let endDate: Date
    @State private var percentage: CGFloat = 0
    
    //MARK: - Init
    init(coin: Coin) {
        self.data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0.0
        maxY = data.max() ?? 0.0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        avaragePrice = (maxY + minY) / 2
        endDate = Date(lastUpdate: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    //MARK: - View
    var body: some View {
        VStack {
            ChartView
                .frame(height: 200)
                .background(ChartBackground)
                .overlay (ChartYAxis, alignment: .leading)
            ChartDateLabels
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1)) {
                    percentage = 1
                }
            }
        }
    }
}

extension ChartView {
    private var ChartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = (geometry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2 , lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.4), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 40)
            .clipped()
        }
    }
    
    private var ChartBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var ChartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(avaragePrice.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var ChartDateLabels: some View {
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}
