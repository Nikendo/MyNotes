//
//  DeleteNoteUseCase.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

protocol DeleteNoteUseCase: AnyObject {
  func execute(note: Note) async throws
}
