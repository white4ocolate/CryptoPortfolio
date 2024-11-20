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
    static let BASE_COIN_DETAIL_URL = "https://api.coingecko.com/api/v3/coins/"
    static let COIN_DETAIL_QUERY = "?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    static let COIN_IMAGES = "COIN_IMAGES"
    static let MARKET_DATA_URL = "https://api.coingecko.com/api/v3/global"
    
    static func coinDetailURL(for coinName: String) -> String {
        return BASE_COIN_DETAIL_URL + coinName + COIN_DETAIL_QUERY
    }
}
