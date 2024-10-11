//
//  FetchAllNotesUseCaseImpl.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

final class FetchAllNotesUseCaseImpl: FetchAllNotesUseCase {
  private let repository: NoteRepository
  
  init(repository: NoteRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> [Note] {
    try await repository.fetchAllNotes()
  }
}
