//
//  NoteRepositoryImpl.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import SwiftData
import Foundation

final class NoteRepositoryImpl: NoteRepository {
  
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  func save(note: Note) async throws {
    var persistentModel: NoteData
    
    // check if the not is existed
    let descriptor = FetchDescriptor<NoteData>()
    if let fromContext = try modelContext.fetch(descriptor).first(where: { $0.id == note.id }) {
      // if the note is existed, update it
      fromContext.title = note.title
      fromContext.message = note.message
      fromContext.date = note.date
      fromContext.mood = note.mood
    } else {
      // else, create new from the domain model
      persistentModel = NoteData(from: note)
      modelContext.insert(persistentModel)
    }
    
    guard modelContext.hasChanges else { return }
    try modelContext.save()
  }
  
  func delete(note: Note) async throws {
    let descriptor = FetchDescriptor<NoteData>()
    guard let persistentModel = try modelContext.fetch(descriptor).first(where: { $0.id == note.id }) else {
      print("Note with id \(note.id) not found.")
      return
    }
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
