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
    private let color: Color

    init(title: String, color: Color = .black, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.color = color
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .tint(color)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color, lineWidth: 3)
                )
        }
    }
}

#Preview {
    BorderedButton(title: "Test Button", color: .black) {

    }
}
