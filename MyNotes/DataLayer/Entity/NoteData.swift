//
//  NoteData.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import Foundation
import SwiftData

@Model
final class NoteData {
  @Attribute(.unique)
  var id: UUID
  var date: Date
  var mood: Mood
  var title: String
  var message: String
  
  init(id: UUID, date: Date, mood: Mood, title: String, message: String) {
    self.id = id
    self.date = date
    self.mood = mood
    self.title = title
    self.message = message
  }
}
