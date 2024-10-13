//
//  NoteListScreenBuilder.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 14.10.2024.
//

import SwiftUI

@MainActor
struct NoteListScreenBuilder {
  let repository: NoteRepository
  let navigationPath: NavigationPath
  
  func build() -> NoteListView {
    let noteListModel = NoteListModel(
      fetchAllNotesUseCase: FetchAllNotesUseCaseImpl(repository: repository),
      deleteNoteUseCase: DeleteNoteUseCaseImpl(repository: repository)
    )
    let noteListViewModel = NoteListViewModel(
      model: noteListModel,
      navigationPath: navigationPath
    )
    return NoteListView(viewModel: noteListViewModel, saveNoteUseCase: SaveNoteUseCaseImpl(repository: repository))
  }
}
