//
//  CoinDetail.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 18.11.2024.
//

import Foundation

struct CoinDetail: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case description
        case links
    }
    
    var readableDescription: String? {
        return description?.en?.removingHTMLOccurances
    }
}

struct Description: Codable {
    let en: String?
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
