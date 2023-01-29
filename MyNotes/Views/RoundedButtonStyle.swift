//
//  ButtonStyles.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.01.2023.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {

    private let foregroundColor: Color
    private let backgroundColor: Color
    private let height: CGFloat

    init(
        foregroundColor: Color = .white,
        backgroundColor: Color = .init("5B90DA"),
        height: CGFloat = 56
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.height = height
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(12)
            .frame(height: 56)
    }
}
