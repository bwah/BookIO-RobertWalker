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

struct FavoriteCalloutView: View {
    var body: some View {
        Text("FAVORITE")
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .background(.yellow)
            .clipShape(Capsule())
    }
}

struct LoadingView: View {
    private let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        VStack {
            ProgressView()
                .padding()
            
            Text(text)
        }
    }
}

struct AppTitleView: View {
    var body: some View {
        Text("Book List")
            .font(.title)
            .bold()
            .padding()
    }
}

