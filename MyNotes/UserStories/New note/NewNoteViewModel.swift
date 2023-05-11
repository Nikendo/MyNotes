//
//  NewNoteViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.05.2023.
//

import Combine

final class NewNoteViewModel: ObservableObject {
    @Published var model: NoteModel

    init(noteModel: NoteModel = .init(id: .init(), date: .now, mood: .normal, title: "", message: "")) {
        self.model = noteModel
    }
}
