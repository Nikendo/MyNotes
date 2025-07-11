//
//  NoteScreenBuilder.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 14.10.2024.
//

import SwiftUI

@MainActor
struct NoteScreenBuilder {
  let saveNoteUseCase: SaveNoteUseCase
  let note: Note
  let isPreview: Bool
  
  init(
    saveNoteUseCase: SaveNoteUseCase,
    note: Note = Note(id: .init(), date: .now, mood: .normal, title: "", message: ""),
    isPreview: Bool = false
  ) {
    self.saveNoteUseCase = saveNoteUseCase
    self.note = note
    self.isPreview = isPreview
  }
  
  func build() -> NoteScreenView {
    let model = NoteScreenModel(saveNoteUseCase: saveNoteUseCase)
    let viewModel = NoteScreenViewModel(
      model: model,
      note: note,
      isPreview: isPreview
    )
    
    return NoteScreenView(viewModel: viewModel)
  }
}
