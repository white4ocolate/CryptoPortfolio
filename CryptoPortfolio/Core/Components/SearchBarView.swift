//
//  SearchBarView.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 17.10.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    //MARK: - Properties
    @Binding var searchText: String
    
    //MARK: - View
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            TextField("Search coin...", text: $searchText)
                .autocorrectionDisabled(true)
                .padding(.trailing, 35)
                .foregroundStyle(Color.theme.secondaryText)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            hideKeyboard()
                            searchText = ""
                        }
                }
        }
        .padding()
        .font(.headline)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),
                        radius: 10,
                        x: 0,
                        y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
