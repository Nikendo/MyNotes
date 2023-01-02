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

    enum Mood: String {
        case sad = "😔"
        case normal = "😐"
        case happy = "😃"
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
