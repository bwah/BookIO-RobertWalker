//
//  BorderedTextField.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BorderedTextField: View {
    let secure: Bool
    let text: Binding<String>
    let placeholder: String

    init(text: Binding<String>, placeholder: String = "", secure: Bool = false) {
        self.text = text
        self.placeholder = placeholder
        self.secure = secure
    }

    var body: some View {
        if secure {
            SecureField(placeholder, text: text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
        } else {
            TextField(placeholder, text: text)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
        }
    }

}

