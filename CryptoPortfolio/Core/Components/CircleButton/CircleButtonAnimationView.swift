//
//  CircleButtonAnimationView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 02.10.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    //MARK: - Properties
    @Binding var isAnimate: Bool
    
    //MARK: - View
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimate ? 1.0 : 0.0)
            .opacity(isAnimate ? 0.0 : 1.0)
            .animation(isAnimate ? Animation.easeOut(duration: 1.0) : .none, value: isAnimate)
    }
}

#Preview {
    CircleButtonAnimationView(isAnimate: .constant(false))
}
