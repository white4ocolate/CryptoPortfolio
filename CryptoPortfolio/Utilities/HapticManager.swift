//
//  HapticManager.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 04.11.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    //MARK: - Properties
    static private let generator = UINotificationFeedbackGenerator()
    
    //MARK: - Methods
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
