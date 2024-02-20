//
//  ContentView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @EnvironmentObject private var appSettings: AppSettings
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \NoteModel.date) private var notes: [NoteModel] = []
  @State private var selectedNote: NoteModel?
  @State private var isPresentedSelectedNote: Bool = false

  var body: some View {
    NavigationView {
      ZStack {
        backgroundView
        contentView
          .ignoresSafeArea()
        navigationViews
      }
    }
  }

  @ViewBuilder private var backgroundView: some View {
    appSettings.appTheme.backgroundColor.ignoresSafeArea()
  }

  @ViewBuilder private var navigationViews: some View {
    VStack {
      CustomNavigationBar()
      Spacer()
      CustomTabBar { newNote in
        modelContext.insert(newNote)
      }
      .fullScreenCover(item: $selectedNote) { item in
        NewNoteView(viewModel: NewNoteViewModel(
          noteModel: item,
          createCompletion: { note in
            modelContext.insert(note)
            self.selectedNote = nil
          }
        ))
      }
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
    appSettings.appTheme.image
      .resizable()
      .scaledToFit()
  }

  @ViewBuilder private var notesList: some View {
    ForEach(appSettings.notesOrder == .reversed ? notes.reversed() : notes) { note in
      NoteView(note: note)
        .padding(.horizontal)
        .onTapGesture {
          selectedNote = note
          isPresentedSelectedNote = true
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .modelContainer(previewContainer)
  }
}
