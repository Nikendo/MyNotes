//
//  CustomNavigationBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
  
  enum Field: Hashable {
    case search
    case none
  }
  
  @EnvironmentObject private var appSettings: AppSettings
  @State private var reversedOrder: Bool = true
  @State private var isSearchMode: Bool = false
  @Binding private var searchableText: String
  @FocusState private var focusedField: Field?
  private let buttonSize: CGFloat = 48
  private let buttonRadius: CGFloat = 16

  init(searchableText: Binding<String>) {
    _searchableText = searchableText
  }
  
  var body: some View {
    HStack {
      leadingGroupViews
      if !isSearchMode {
        Spacer()
      }
      trailingGroupViews
    }
    .padding(.horizontal, 8)
    .foregroundStyle(appSettings.appTheme.navbarTintColor)
    .onChange(of: reversedOrder) { _, newValue in
      UserDefaults.standard.set(newValue, forKey: "notes_order")
    }
    .onAppear(perform: {
      reversedOrder = UserDefaults.standard.bool(forKey: "notes_order")
    })
  }

  @ViewBuilder private var menuView: some View {
    Menu(
      content: {
        ForEach(AppSettings.AppTheme.allCases, id: \.name) { theme in
          Button(
            action: {
              appSettings.appTheme = theme
            },
            label: {
              HStack {
                Text(theme.name)
                if appSettings.appTheme == theme {
                  Image(systemName: "checkmark")
                }
              }
            }
          )
        }
      },
      label: {
        Image(systemName: "line.3.horizontal")
          .frame(width: buttonSize, height: buttonSize)
          .background(Color.white.opacity(0.6))
          .clipShape(RoundedRectangle(cornerRadius: buttonRadius))
      }
    )
  }

  @ViewBuilder private var searchView: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .frame(width: buttonSize, height: buttonSize)
        .onTapGesture {
          withAnimation {
            isSearchMode.toggle()
            focusedField = isSearchMode ? .search : nil
          }
        }
      if isSearchMode {
        TextField("Searchable note...", text: $searchableText)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .focused($focusedField, equals: Field.search)
          .showClearButton($searchableText)
          .onSubmit {
            focusedField = nil
          }
      }
    }
    .background(Color.white.opacity(isSearchMode ? 1 : 0.6))
    .clipShape(RoundedRectangle(cornerRadius: buttonRadius))
  }

  @ViewBuilder private var orderView: some View {
    Menu(
      content: {
        Button(
          action: {
            appSettings.notesOrder = .reversed
          },
          label: {
            HStack {
              Text("First newest")
              if appSettings.notesOrder == .reversed {
                Image(systemName: "checkmark")
              }
            }
          }
        )
        Button(
          action: {
            appSettings.notesOrder = .forwarded
          },
          label: {
            HStack {
              Text("First oldest")
              if appSettings.notesOrder == .forwarded {
                Image(systemName: "checkmark")
              }
            }
          }
        )
      },
      label: {
        Image(systemName: "arrow.up.arrow.down")
          .frame(width: buttonSize, height: buttonSize)
          .background(Color.white.opacity(0.6))
          .clipShape(RoundedRectangle(cornerRadius: buttonRadius))
      }
    )
  }

  @ViewBuilder private var leadingGroupViews: some View {
    HStack {
      menuView
    }
  }

  @ViewBuilder private var trailingGroupViews: some View {
    HStack {
      searchView
      orderView
    }
  }
}

struct CustomNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavigationBar(searchableText: .constant(""))
  }
}
