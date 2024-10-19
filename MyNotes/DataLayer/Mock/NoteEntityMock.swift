//
//  NoteEntityMock.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 14.10.2024.
//

import Foundation

enum NoteEntityMock {
  static var mock: Note {
    Note(
      id: UUID(),
      date: Date(),
      mood: .normal,
      title: "Multilined\nText\nFor this\nnote",
      message: "Multy\nMylty\nMultilined description\nFor\nThis note"
    )
  }
}
