//
//  BorderedButton.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BorderedButton: View {
    private let title: String
    private let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
    }
}
