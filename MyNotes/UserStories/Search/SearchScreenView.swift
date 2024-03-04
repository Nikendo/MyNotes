//
//  SearchScreenView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 04.03.2024.
//

import SwiftUI
import SwiftData

struct SearchScreenView: View {
  @EnvironmentObject private var appSettings: AppSettings
  @Environment(\.modelContext) private var modelContext

  @Query private var notes: [NoteModel]

  @State private var searchableText: String = ""
  @State private var selectedNote: NoteModel?
  @State private var isPresentedSelectedNote: Bool = false

  var body: some View {
    List(notes.filter { !$0.title.isEmpty ? $0.title.contains(searchableText) : $0.message.contains(searchableText)}) { note in
      NoteView(note: note)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(.horizontal)
        .onTapGesture {
          selectedNote = note
          isPresentedSelectedNote = true
        }
    }
    .listRowSpacing(12)
    .listStyle(.inset)
    .scrollContentBackground(.hidden)
    .searchable(text: $searchableText, prompt: "Searchable note...")
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

#Preview {
  SearchScreenView()
}
