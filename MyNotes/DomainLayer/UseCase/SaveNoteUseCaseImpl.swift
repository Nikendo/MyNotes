//
//  SaveNoteUseCaseImpl.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

final class SaveNoteUseCaseImpl: SaveNoteUseCase {
  
  private let repository: NoteRepository
  
  init(repository: NoteRepository) {
    self.repository = repository
  }
  
  func execute(note: Note) async throws {
    try await repository.save(note: note)
  }
}
