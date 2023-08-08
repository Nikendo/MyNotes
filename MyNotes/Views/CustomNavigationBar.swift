//
//  CustomNavigationBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
  var body: some View {
    HStack {
      leadingGroupViews
      Spacer()
      trailingGroupViews
    }
    .padding(.horizontal, 8)
    .background(.clear)
    .foregroundColor(.primary)
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
    Button(
      action: {
        print("order button action")
      },
      label: {
        Image(systemName: "arrow.up.arrow.down")
      }
    )
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
