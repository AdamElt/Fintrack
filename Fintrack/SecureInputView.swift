//
//  SecureInputView.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 4/9/25.
//

import SwiftUI

struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    var body: some View {
        HStack {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .padding()

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .background(Color.white.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    LogInView()
}
