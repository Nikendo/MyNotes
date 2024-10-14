//
//  NoteListViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import SwiftUI
import Combine

@MainActor
final class NoteListViewModel: ObservableObject {
  
  enum NavigationCase: Hashable {
    case note(note: Note)
    case newNote
  }
  
  private let model: NoteListModel
  
  @Published private var allNotes: [Note] = []
  @Published var notes: [Note] = []
  @Published var searchableText: String = ""
  @Published var navigationPath: NavigationPath
  
  init(model: NoteListModel, navigationPath: NavigationPath) {
    self.model = model
    self.navigationPath = navigationPath
  }
  
  func fetchAllNotes() async {
    do {
      allNotes = try await model.fetchAllNotes()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func refreshData() {
    Task {
      do {
        allNotes = try await model.fetchAllNotes()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteNoteUseCase(note: Note) {
    Task {
      do {
        try await model.deleteNoteUseCase(note: note)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func navigateToExistedNote(note: Note) {
    navigationPath.append(NavigationCase.note(note: note))
  }
  
  func navigateToNewNote() {
    navigationPath.append(NavigationCase.newNote)
  }
  
  func bindInput() {
    $allNotes.combineLatest($searchableText).compactMap { allNotes, searchableText in
      guard !searchableText.isEmpty else { return allNotes }
      return allNotes.filter { !$0.title.lowercased().isEmpty ? $0.title.lowercased().contains(searchableText.lowercased()) : $0.message.lowercased().contains(searchableText.lowercased()) }
    }
    .assign(to: &$notes)
  }
}
