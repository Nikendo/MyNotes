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

extension Mood: Codable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let val = try container.decode(String.self)
    self = switch val {
    case "😔": Mood.sad
    case "😐": Mood.normal
    case "😃": Mood.happy
    default: throw DecodingError.typeMismatch(Mood.self, DecodingError.Context.init(
        codingPath: container.codingPath,
        debugDescription: "Unexpected value of '\(val)'",
        underlyingError: nil
      ))
    }
  }

  enum CodingKeys: CodingKey {
    case sad, normal, happy
  }
}
