//
//  CustomBottomNavigationBarViewModifier.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 13.10.2024.
//

import SwiftUI

struct CustomBottomNavigationBarViewModifier: ViewModifier {
  var action: () -> Void
  
  func body(content: Content) -> some View {
    content
      .overlay(alignment: .bottom) {
        CustomBottomNavigationBar(action: action)
    }
  }
}

extension View {
  func customBottomNavigationbar(action: @escaping () -> Void) -> some View {
    modifier(CustomBottomNavigationBarViewModifier(action: action))
  }
}
