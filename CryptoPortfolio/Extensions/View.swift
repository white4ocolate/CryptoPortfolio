//
//  View.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 17.10.2024.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
}
