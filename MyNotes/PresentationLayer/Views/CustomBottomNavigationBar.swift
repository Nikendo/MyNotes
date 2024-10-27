//
//  CustomBottomNavigationBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 13.10.2024.
//

import SwiftUI

struct CustomBottomNavigationBar: View {
  @EnvironmentObject private var appSettings: AppSettings
  
  var action: () -> Void
  
  var body: some View {
    addButtonView
  }
  
  @ViewBuilder
  private var addButtonView: some View {
    Button(action: action) {
      Image(systemName: "plus")
        .resizable()
        .frame(width: 24, height: 24)
        .padding()
        .background(appSettings.appTheme.newNoteButtonBackgroundColor)
        .foregroundStyle(appSettings.appTheme.backgroundColor)
        .cornerRadius(28)
    }
  }
}
