//
//  NoteModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import Foundation
import SwiftData

@Model
final class NoteModel: Identifiable {
  @Attribute(.unique) let id: UUID
  var date: Date
  var mood: Mood
  var title: String
  var message: String

  enum Mood: String, CaseIterable, Codable {
    case sad = "😔"
    case normal = "😐"
    case happy = "😃"

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
  
  init(id: UUID, date: Date, mood: Mood, title: String, message: String) {
    self.id = id
    self.date = date
    self.mood = mood
    self.title = title
    self.message = message
  }
  
  static func getDefault(withTitle: Bool = true, long: Bool = false) -> NoteModel {
    .init(
      id: .init(),
      date: .now,
      mood: .normal,
      title: withTitle ? "New note" : "",
      message: long ? "Template of message\nTemplate of message Template of message\nTemplate of message\nTemplate of message\nTemplate of message" : "Template of message"
    )
  }
}
