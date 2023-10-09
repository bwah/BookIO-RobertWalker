//
//  UtilityViews.swift
//  BookIO
//
//  Created by Robert Walker on 10/9/23.
//

import SwiftUI

struct ErrorText: View {
    private let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.callout)
            .foregroundStyle(.red)
            .multilineTextAlignment(.center)
            .padding()
    }

}
