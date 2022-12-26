//
//  ContentView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            backgroundView
            contentView
                .ignoresSafeArea()
            navigationBarView
        }
    }

    @ViewBuilder private var backgroundView: some View {
        Color("4E7700").ignoresSafeArea()
    }

    @ViewBuilder private var navigationBarView: some View {
        VStack {
            CustomNavigationBar()
            Spacer()
            CustomTabBar()
        }
    }

    @ViewBuilder private var contentView: some View {
        VStack {
            Image("landscape_summer_1")
                .resizable()
                .scaledToFit()
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
