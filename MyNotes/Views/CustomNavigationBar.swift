//
//  CustomNavigationBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
  @EnvironmentObject private var appSettings: AppSettings
  @State private var reversedOrder: Bool = true

  var body: some View {
    HStack {
      leadingGroupViews
      Spacer()
      trailingGroupViews
    }
    .padding(.horizontal, 8)
    .background(.clear)
    .foregroundColor(.primary)
    .onChange(of: reversedOrder) { _, newValue in
      UserDefaults.standard.set(newValue, forKey: "notes_order")
    }
    .onAppear(perform: {
      reversedOrder = UserDefaults.standard.bool(forKey: "notes_order")
    })
  }

  @ViewBuilder private var menuView: some View {
    Button(
      action: {
        print("menu button action")
      },
      label: {
        Image(systemName: "line.3.horizontal")
      }
    )
    .frame(width: 48, height: 48)
  }

  @ViewBuilder private var searchView: some View {
    Button(
      action: {
        print("search button action")
      },
      label: {
        Image(systemName: "magnifyingglass")
      }
    )
    .frame(width: 48, height: 48)
  }

  @ViewBuilder private var orderView: some View {
    Menu("", systemImage: "arrow.up.arrow.down") {
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
    }
    .frame(width: 48, height: 48)
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
    CustomNavigationBar()
  }
}
