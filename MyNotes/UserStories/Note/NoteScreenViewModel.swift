//
//  NewNoteViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.05.2023.
//

import Combine

final class NoteScreenViewModel: ObservableObject {

  // MARK: - Publishers

  @Published var noteViewState: ViewState
  @Published var model: NoteModel
  @Published private(set) var destination: Flow.Destination = .none
  @Published private(set) var canSave: Bool = false

  // MARK: - Private Properties

  private let createCompletion: (NoteModel) -> Void
  
  // MARK: - Init

  init(
    noteModel: NoteModel = .init(id: .init(), date: .now, mood: .normal, title: "", message: ""),
    isPreview: Bool = false,
    createCompletion: @escaping (NoteModel) -> Void
  ) {
    self.model = noteModel
    self.createCompletion = createCompletion
    self.noteViewState = isPreview ? .preview : .new(filled: false)
    bindInput()
  }

  func save() {
    printModel(model)
    createCompletion(model)
    destination = .save
  }
    
    func switchToEditMode() {
        noteViewState = .edit(filled: canSave)
    }

  func cancel() {
    debugPrint("Cancel")
    destination = .cancel
  }
}

private extension NoteScreenViewModel {

  // MARK: - Private Methods

  func bindInput() {
    $model.map { !$0.title.isEmpty || !$0.message.isEmpty }.assign(to: &$canSave)
    $canSave.map { [weak self] in
      guard let self else { return ViewState.new(filled: $0) }
      return switch noteViewState {
      case .edit: ViewState.edit(filled: $0)
      case .new: ViewState.new(filled: $0)
      case .preview: ViewState.preview
      }
    }
    .assign(to: &$noteViewState)
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
