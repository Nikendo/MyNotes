//
//  NoteModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import Foundation

struct NoteModel: Identifiable {
    let id: UUID
    let date: Date
    let mood: Mood
    let title: String
    let message: String

    enum Mood {
        case sad
        case normal
        case happy
    }

    static func getDefault() -> NoteModel {
        .init(
            id: .init(),
            date: .now,
            mood: .normal,
            title: "New note",
            message: "Template of message"
        )
    }
}
