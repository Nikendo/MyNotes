//
//  NoteListModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import Foundation

final class NoteListModel {
  private let fetchAllNotesUseCase: FetchAllNotesUseCase
  private let deleteNoteUseCase: DeleteNoteUseCase
  
  init(fetchAllNotesUseCase: FetchAllNotesUseCase, deleteNoteUseCase: DeleteNoteUseCase) {
    self.fetchAllNotesUseCase = fetchAllNotesUseCase
    self.deleteNoteUseCase = deleteNoteUseCase
  }
  
  func fetchAllNotes() async throws -> [Note] {
    try await fetchAllNotesUseCase.execute()
  }
  
  func deleteNoteUseCase(note: Note) async throws {
    try await deleteNoteUseCase.execute(note: note)
  }
}
