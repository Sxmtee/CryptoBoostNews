//
//  ReusableButton.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//


import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let height: CGFloat
    let width: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let borderColor: Color
    let text: String
    let font: Font

    init(
        action: @escaping () -> Void,
        height: CGFloat = 60,
        width: CGFloat = 200,
        backgroundColor: Color = Color.blue,
        textColor: Color = Color.white,
        borderColor: Color = Color.clear,
        text: String,
        font: Font = .body
    ) {
        self.action = action
        self.height = height
        self.width = width
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.text = text
        self.font = font
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: width, height: height)
        .background(backgroundColor)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}
