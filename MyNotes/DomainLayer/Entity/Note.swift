//
//  Note.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import Foundation

struct Note {
  let id: UUID
  let date: Date
  let mood: Mood
  let title: String
  let message: String
}
