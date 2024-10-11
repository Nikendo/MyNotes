//
//  NoteRepository.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

protocol NoteRepository: AnyObject {
  func save(note: Note) async throws
  func delete(note: Note) async throws
  func fetchAllNotes() async throws -> [Note]
}
