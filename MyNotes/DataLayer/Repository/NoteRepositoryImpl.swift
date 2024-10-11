//
//  NoteRepositoryImpl.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import SwiftData

final class NoteRepositoryImpl: NoteRepository {
  
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  func save(note: Note) async throws {
    let persistentModel = NoteData(from: note)
    modelContext.insert(persistentModel)
    
    guard modelContext.hasChanges else { return }
    try modelContext.save()
  }
  
  func delete(note: Note) async throws {
    let persistentModel = NoteData(from: note)
    modelContext.delete(persistentModel)
    
    guard modelContext.hasChanges else { return }
    try modelContext.save()
  }
  
  func fetchAllNotes() async throws -> [Note] {
    let descriptor = FetchDescriptor<NoteData>()
    let domainModels = try modelContext.fetch(descriptor).map { Note(from: $0) }
    return domainModels
  }
}
