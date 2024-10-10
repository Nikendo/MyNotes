//
//  NoteScreenModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import Foundation

final class NoteScreenModel {
  private let saveNoteUseCase: SaveNoteUseCase
  
  init(saveNoteUseCase: SaveNoteUseCase) {
    self.saveNoteUseCase = saveNoteUseCase
  }
  
  func saveNote(note: Note) async throws {
    try await saveNoteUseCase.execute(note: note)
  }
}
