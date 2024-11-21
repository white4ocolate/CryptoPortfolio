//
//  String.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 21.11.2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        
    }
}
