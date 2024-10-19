//
//  TextFieldClearButton.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.10.2024.
//

import SwiftUI


struct TextFieldClearButton: ViewModifier {
  @Binding var text: String
  
  func body(content: Content) -> some View {
    content
      .overlay {
        HStack {
          if !text.isEmpty {
            Spacer()
            Button("", systemImage: "xmark.circle.fill") {
              text = ""
            }
          }
        }
      }
  }
}

extension View {
  func showClearButton(_ text: Binding<String>) -> some View {
    self.modifier(TextFieldClearButton(text: text))
  }
}
