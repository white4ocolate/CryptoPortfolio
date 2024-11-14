//
//  Constants.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import Foundation

struct Constants {
    
    //MARK: - Properties
    static let ALL_COINS_URL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    static let COIN_IMAGES = "COIN_IMAGES"
    static let MARKET_DATA_URL = "https://api.coingecko.com/api/v3/global"
}
