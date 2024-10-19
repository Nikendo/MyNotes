//
//  CustomNavigationBarViewModifier.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 13.10.2024.
//

import SwiftUI

struct CustomNavigationBarViewModifier: ViewModifier {
  @Binding var searchableText: String
  
  func body(content: Content) -> some View {
    content
      .overlay(alignment: .top) {
        CustomNavigationBar(searchableText: $searchableText)
      }
  }
}

extension View {
  func customNavigationBar(searchableText: Binding<String>) -> some View {
    modifier(CustomNavigationBarViewModifier(searchableText: searchableText))
  }
}
