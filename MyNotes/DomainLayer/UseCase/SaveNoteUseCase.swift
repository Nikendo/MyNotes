//
//  SaveNoteUseCase.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

protocol SaveNoteUseCase: AnyObject {
  func execute(note: Note) async throws
}
