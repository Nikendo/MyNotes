//
//  NewNoteViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.05.2023.
//

import Combine

final class NewNoteViewModel: ObservableObject {
    @Published var model: NoteModel
    @Published private(set) var state: Flow.ViewState = .normal
    @Published private(set) var destination: Flow.Destination = .none

    private(set) var eventSubject = PassthroughSubject<Flow.Event, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init(noteModel: NoteModel = .init(id: .init(), date: .now, mood: .normal, title: "", message: "")) {
        self.model = noteModel
        bindInput()
    }

    private func bindInput() {
        eventSubject.sink { [weak self] event in
            guard let self = self else {
                return
            }

            switch event {
            case .save:
                print("Save ->")
                print("id: \(model.id)")
                print("date: \(model.date)")
                print("title: \(model.title)")
                print("message: \(model.message)")
                print("mood: \(model.mood)")
                self.destination = .save
            case .cancel:
                print("Cancel")
                self.destination = .cancel
            }
        }.store(in: &subscriptions)
    }
}
