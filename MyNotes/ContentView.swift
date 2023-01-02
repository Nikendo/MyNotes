//
//  ContentView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI

struct ContentView: View {

    @State var notes: [NoteModel] = [
        .getDefault(),
        .getDefault(),
        .getDefault(),
        .getDefault(long: true),
        .getDefault()
    ]

    var body: some View {
        ZStack {
            backgroundView
            contentView
                .ignoresSafeArea()
            navigationViews
        }
    }

    @ViewBuilder private var backgroundView: some View {
        Color("4E7700").ignoresSafeArea()
    }

    @ViewBuilder private var navigationViews: some View {
        VStack {
            CustomNavigationBar()
            Spacer()
            CustomTabBar()
        }
    }

    @ViewBuilder private var contentView: some View {
        ScrollView {
            contentHeaderView
            notesList
            Spacer()
                .frame(minHeight: 124)
        }
    }

    @ViewBuilder private var contentHeaderView: some View {
        Image("landscape_summer_1")
            .resizable()
            .scaledToFit()
    }

    @ViewBuilder private var notesList: some View {
            ForEach(notes) { note in
                NoteView(note: note)
                    .padding(.horizontal)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
