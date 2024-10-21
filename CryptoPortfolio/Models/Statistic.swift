//
//  Statistic.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.10.2024.
//

import Foundation
import SwiftUI

struct Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String?
    let percentageChange: Double?
    
    init(title: String, value: String? = nil, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
