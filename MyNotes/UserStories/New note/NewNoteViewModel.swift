//
//  NewNoteViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.05.2023.
//

import Combine

final class NewNoteViewModel: ObservableObject {

  // MARK: - Publishers

  @Published var model: NoteModel
  @Published private(set) var destination: Flow.Destination = .none
  @Published private(set) var canSave: Bool = false

  // MARK: - Private Properties

  private let createCompletion: (NoteModel) -> Void
  
  // MARK: - Init

  init(
    noteModel: NoteModel = .init(id: .init(), date: .now, mood: .normal, title: "", message: ""),
    createCompletion: @escaping (NoteModel) -> Void
  ) {
    self.model = noteModel
    self.createCompletion = createCompletion
    bindInput()
  }

  func save() {
    printModel(model)
    createCompletion(model)
    destination = .save
  }

  func cancel() {
    debugPrint("Cancel")
    destination = .cancel
  }
}

private extension NewNoteViewModel {

  // MARK: - Private Methods

  func bindInput() {
    $model.map { !$0.title.isEmpty || !$0.message.isEmpty }.assign(to: &$canSave)
  }

  func printModel(_ model: NoteModel) {
    debugPrint("Save ->")
    debugPrint("id: \(model.id)")
    debugPrint("date: \(model.date)")
    debugPrint("title: \(model.title)")
    debugPrint("message: \(model.message)")
    debugPrint("mood: \(model.mood)")
  }
}
