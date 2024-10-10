//
//  NoteMapper.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import Foundation

extension Note {
  init(from dataModel: NoteData) {
    self.init(
      id: dataModel.id,
      date: dataModel.date,
      mood: dataModel.mood,
      title: dataModel.title,
      message: dataModel.message
    )
  }
}

extension NoteData {
  convenience init(from domainModel: Note) {
    self.init(
      id: domainModel.id,
      date: domainModel.date,
      mood: domainModel.mood,
      title: domainModel.title,
      message: domainModel.message
    )
  }
}
