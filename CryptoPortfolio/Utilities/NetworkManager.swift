//
//  NetworkManager.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 09.10.2024.
//

import Foundation
import Combine

class NetworkManager {
    
    //MARK: - Properties
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case rateLimit
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[⛔️] Bad response from URL=\(url)"
            case .rateLimit: return "[⏳] You've exceeded the Rate Limit. Please try again later."
            case .unknown: return "[⚠️] Unknown error"
            }
        }
    }
    
    //MARK: - Methods
    static func downloadData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        if response.statusCode == 429 {
            throw NetworkError.rateLimit
        } else if (response.statusCode < 200 || response.statusCode >= 300) {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(_ completion: Subscribers.Completion<any Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
